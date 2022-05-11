import XCTest
import RxSwift

@testable import App

class LogInViewModelTests: XCTestCase {

    var router: LogInRouterMock!
    var commandsExecuter: CommandsExecuterMock!
    var SUT: LogInViewModel!

    override func setUp() {
        super.setUp()
        router = LogInRouterMock()
        commandsExecuter = CommandsExecuterMock()
        SUT = LogInViewModel(
            statePublisher: .init(),
            router: router,
            commandsExecuter: commandsExecuter
        )
    }

    override func tearDown() {
        super.tearDown()
        router = nil
        commandsExecuter = nil
        SUT = nil
    }

    func testSendCommandsHasBeenSelected() {
        // Sets up bag for view model
        SUT.viewWillAppear()

        SUT.sendCommandsHasBeenSelected()

        XCTAssertTrue(commandsExecuter.didCallSendCommands)
    }
}

extension LogInViewModelTests {

    class LogInRouterMock: LogInRouterProtocol {

        var didCalSignUp = false

        func signUp() {
            didCalSignUp = true
        }
    }

    class CommandsExecuterMock: CommandsExecuter {

        var didCallSendCommands = false

        override func sendCommands() -> Observable<String> {
            didCallSendCommands = true
            return Observable.just("")
        }
    }
}
