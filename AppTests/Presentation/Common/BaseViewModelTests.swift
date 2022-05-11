import XCTest
import RxSwift
import RxTest

@testable import App

class BaseViewModelTests: XCTestCase {

    var scheduler: TestScheduler!
    var statePublisher: StatePublisher!
    var SUT: BaseViewModelProtocol!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        statePublisher = StatePublisher(
            scheduler: scheduler,
            interval: .seconds(1),
            shouldEmitAutomatically: false
        )
        SUT = BaseViewModel(statePublisher: statePublisher)
    }

    override func tearDown() {
        super.tearDown()
        scheduler = nil
        statePublisher = nil
        SUT = nil
    }

    func testViewWillAppear() {
        SUT.viewWillAppear()

        scheduler.scheduleAt(11) {
            self.scheduler.stop()
        }

        let result = scheduler.start(created: 0, subscribed: 0, disposed: 11) {
            self.SUT.popUpAlert
        }

        for (index, element) in result.events.enumerated() where index > 0 {
            let previous = result.events[index - 1]
            XCTAssertNotEqual(previous.value.element, element.value.element)
        }
    }

    func testViewWillDisappear() {
        SUT.viewWillAppear()

        scheduler.scheduleAt(11) {
            self.SUT.viewWillDisappear()
        }

        let result = scheduler.start(created: 0, subscribed: 0, disposed: 11) {
            self.SUT.popUpAlert
        }

        for (index, element) in result.events.enumerated() where index > 0 {
            let previous = result.events[index - 1]
            XCTAssertNotEqual(previous.value.element, element.value.element)
        }
    }

    func testButtonHasBeenSelected() {
        statePublisher = StatePublisherStub(scheduler: scheduler, interval: .seconds(1))
        SUT = BaseViewModel(statePublisher: statePublisher)

        SUT.viewWillAppear()
        scheduler.scheduleAt(1) {
            self.SUT.buttonHasBeenSelected()
        }
        scheduler.scheduleAt(2) {
            self.SUT.buttonHasBeenSelected()
        }

        let result = scheduler.start(created: 0, subscribed: 0, disposed: 3) {
            self.SUT.popUpAlert
        }

        let expected: [Recorded<Event<String>>] = [
            .init(time: 1, value: .next("Message Sent")),
            .init(time: 2, value: .next("Message Sent"))
        ]
        XCTAssertEqual(result.events, expected)
    }
}

private extension BaseViewModelTests {

    class StatePublisherStub: StatePublisher {

        override func startObserving() -> Observable<StatePublisher.State> {
            Observable.create { observer in
                observer.onNext(.established)
                return Disposables.create()
            }
        }
    }
}
