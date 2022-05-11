import UIKit

protocol ForgotPasswordRouterProtocol: AnyObject {
    func back()
}

final class ForgotPasswordRouter: ForgotPasswordRouterProtocol, RouterProtocol {

    weak var parent: RouterProtocol?

    var children: [RouterProtocol] = []
    let statePublisher: StatePublisher
    let navigationController: UINavigationController

    init(
        parent: RouterProtocol,
        statePublisher: StatePublisher,
        navigationController: UINavigationController
    ) {
        self.parent = parent
        self.statePublisher = statePublisher
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = ForgotPasswordViewModel(statePublisher: statePublisher, router: self)
        let controller = ForgotPasswordViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }

    func back() {
        navigationController.popViewController(animated: true)
        parent?.remove(child: self)
    }
}
