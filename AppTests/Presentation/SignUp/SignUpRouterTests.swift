import XCTest

@testable import App

class SignUpRouterTests: XCTestCase {

    var parent: MainRouter!
    var navigationController: UINavigationControllerMock!
    var SUT: SignUpRouter!

    override func setUp() {
        super.setUp()
        parent = MainRouter(statePublisher: .init(), window: .init())
        navigationController = UINavigationControllerMock()
        SUT = SignUpRouter(parent: parent, statePublisher: .init(), navigationController: navigationController)
    }

    override func tearDown() {
        super.tearDown()
        parent = nil
        navigationController = nil
        SUT = nil
    }

    func testStart() {
        SUT.start()
        XCTAssertTrue(navigationController.pushedController is SignUpViewController)
    }

    func testForgotPassword() {
        SUT.forgotPassword()
        XCTAssertTrue(SUT.children.first is ForgotPasswordRouter)
        XCTAssertTrue(navigationController.pushedController is ForgotPasswordViewController)
    }

    func testBack() {
        parent.add(child: SUT)

        SUT.back()
        XCTAssertTrue(parent.children.isEmpty)
        XCTAssertTrue(navigationController.didPop)
    }
}
