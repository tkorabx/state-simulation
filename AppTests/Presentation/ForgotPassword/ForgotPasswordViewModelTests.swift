import XCTest

@testable import App

class ForgotPasswordViewModelTests: XCTestCase {

    var router: ForgotPasswordRouterMock!
    var SUT: ForgotPasswordViewModel!

    override func setUp() {
        super.setUp()
        router = ForgotPasswordRouterMock()
        SUT = ForgotPasswordViewModel(statePublisher: .init(), router: router)
    }

    override func tearDown() {
        super.tearDown()
        router = nil
        SUT = nil
    }

    func testBack() {
        SUT.backBarButtonSelected()
        XCTAssertTrue(router.didCallBack)
    }
}

extension ForgotPasswordViewModelTests {

    class ForgotPasswordRouterMock: ForgotPasswordRouterProtocol {

        var didCallBack = false

        func back() {
            didCallBack = true
        }
    }
}
