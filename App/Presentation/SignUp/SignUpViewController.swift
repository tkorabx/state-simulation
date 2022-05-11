import UIKit

class SignUpViewController: BaseViewController {

    init(viewModel: BaseViewModelProtocol) {
        super.init(title: "Sign Up", viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addBackNavigationButton()
    }
}
