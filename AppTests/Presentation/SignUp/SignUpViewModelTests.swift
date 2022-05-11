import XCTest

@testable import App

class SignUpViewModelTests: XCTestCase {

    var router: SignUpRouterMock!
    var SUT: SignUpViewModel!

    override func setUp() {
        super.setUp()
        router = SignUpRouterMock()
        SUT = SignUpViewModel(statePublisher: .init(), router: router)
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

extension SignUpViewModelTests {

    class SignUpRouterMock: SignUpRouterProtocol {

        var didCallForgotPassword = false
        var didCallBack = false

        func forgotPassword() {
            didCallForgotPassword = true
        }

        func back() {
            didCallBack = true
        }
    }
}
