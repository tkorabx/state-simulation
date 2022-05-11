import XCTest

@testable import App

class LogInRouterTests: XCTestCase {

    var navigationController: UINavigationControllerMock!
    var SUT: LogInRouter!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationControllerMock()
        SUT = LogInRouter(statePublisher: .init(), navigationController: navigationController)
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
        SUT = nil
    }

    func testStart() {
        SUT.start()
        XCTAssertTrue(navigationController.pushedController is LogInViewController)
    }

    func testSignUp() {
        SUT.signUp()
        XCTAssertTrue(SUT.children.first is SignUpRouter)
        XCTAssertTrue(navigationController.pushedController is SignUpViewController)
    }
}
