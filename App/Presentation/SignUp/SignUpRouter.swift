import UIKit

protocol SignUpRouterProtocol: AnyObject {
    func forgotPassword()
    func back()
}

final class SignUpRouter: SignUpRouterProtocol, RouterProtocol {

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
        let viewModel = SignUpViewModel(statePublisher: statePublisher, router: self)
        let controller = SignUpViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }

    func forgotPassword() {
        let router = ForgotPasswordRouter(
            parent: self,
            statePublisher: statePublisher,
            navigationController: navigationController
        )
        add(child: router)
    }

    func back() {
        navigationController.popViewController(animated: true)
        parent?.remove(child: self)
    }
}
