import UIKit

class ForgotPasswordViewController: BaseViewController {

    init(viewModel: BaseViewModelProtocol) {
        super.init(title: "Forgot Password", viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addBackNavigationButton()
    }
}
