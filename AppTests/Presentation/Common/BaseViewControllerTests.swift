import XCTest
import RxSwift

@testable import App

class BaseViewControllerTests: XCTestCase {

    var viewModel: BaseViewModelMock!
    var SUT: BaseViewController!

    override func setUp() {
        super.setUp()
        viewModel = BaseViewModelMock()
        SUT = BaseViewController(title: "", viewModel: viewModel)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        SUT = nil
    }

    func testViewDidLoad() {
        SUT.viewDidLoad()
        XCTAssertTrue(viewModel.didStartObservingAlert)
    }

    func testViewWillAppear() {
        SUT.viewWillAppear(true)
        XCTAssertTrue(viewModel.didCallViewWillAppear)
    }

    func testViewWillDisappear() {
        SUT.viewWillDisappear(true)
        XCTAssertTrue(viewModel.didCallViewWillDisappear)
    }

    func testButtonHasBeenSelected() {
        SUT.button.sendActions(for: .touchUpInside)
        XCTAssertTrue(viewModel.didCallButtonHasBeenSelected)
    }
}

extension BaseViewControllerTests {

    class BaseViewModelMock: BaseViewModelProtocol {

        var didStartObservingAlert = false
        var didCallButtonHasBeenSelected = false
        var didCallViewWillAppear = false
        var didCallViewWillDisappear = false
        var didCallBackBarButtonSelected = false

        var popUpAlert: Observable<String> {
            didStartObservingAlert = true
            return Observable.create { _ in
                Disposables.create()
            }
        }

        func buttonHasBeenSelected() {
            didCallButtonHasBeenSelected = true
        }

        func viewWillAppear() {
            didCallViewWillAppear = true
        }

        func viewWillDisappear() {
            didCallViewWillDisappear = true
        }

        func backBarButtonSelected() {
            didCallBackBarButtonSelected = true
        }

        func popUpActionHasBeenSelected() {

        }
    }
}
