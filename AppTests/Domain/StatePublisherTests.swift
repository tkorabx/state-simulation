import XCTest
import RxSwift
import RxTest

@testable import App

class StatePublisherTests: XCTestCase {

    func test() {
        let scheduler = TestScheduler(initialClock: 0)
        let SUT = StatePublisher(
            scheduler: scheduler,
            interval: .seconds(100),
            shouldEmitAutomatically: false
        )

        let result = scheduler.start(created: 0, subscribed: 0, disposed: 1000) {
            SUT.startObserving()
        }

        for (index, element) in result.events.enumerated() where index > 0 {
            let previous = result.events[index - 1]
            XCTAssertNotEqual(previous.value.element, element.value.element)
        }
    }
}
