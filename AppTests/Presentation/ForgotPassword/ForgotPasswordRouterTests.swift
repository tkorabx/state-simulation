import XCTest

@testable import App

class ForgotPasswordRouterTests: XCTestCase {

    var parent: MainRouter!
    var navigationController: UINavigationControllerMock!
    var SUT: ForgotPasswordRouter!

    override func setUp() {
        super.setUp()
        parent = MainRouter(statePublisher: .init(), window: .init())
        navigationController = UINavigationControllerMock()
        SUT = ForgotPasswordRouter(parent: parent, statePublisher: .init(), navigationController: navigationController)
    }

    override func tearDown() {
        super.tearDown()
        parent = nil
        navigationController = nil
        SUT = nil
    }

    func testStart() {
        SUT.start()
        XCTAssertTrue(navigationController.pushedController is ForgotPasswordViewController)
    }

    func testBack() {
        parent.add(child: SUT)

        SUT.back()
        XCTAssertTrue(parent.children.isEmpty)
        XCTAssertTrue(navigationController.didPop)
    }
}
