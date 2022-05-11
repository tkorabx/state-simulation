import XCTest
import RxSwift
import RxTest

@testable import App

class CommandsExecuterTests: XCTestCase {

    func test() {
        let scheduler = TestScheduler(initialClock: 0)
        let SUT = CommandsExecuter(scheduler: scheduler)

        scheduler
            .start(created: 0, subscribed: 0, disposed: 56) {
                SUT.sendCommands()
            }
            .events
            .enumerated()
            .forEach { index, element in
                let expectedTime = (1...(index + 1)).reduce(0, +)
                XCTAssertEqual(element.time, expectedTime)
                XCTAssertEqual(element.value.element, "1.\(index + 1)")
            }
    }
}
