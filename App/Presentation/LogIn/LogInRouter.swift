import UIKit

protocol LogInRouterProtocol: AnyObject {
    func signUp()
}

final class LogInRouter: LogInRouterProtocol, RouterProtocol {

    weak var parent: RouterProtocol?

    var children: [RouterProtocol] = []
    let statePublisher: StatePublisher
    let navigationController: UINavigationController

    init(
        statePublisher: StatePublisher,
        navigationController: UINavigationController
    ) {
        self.statePublisher = statePublisher
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = LogInViewModel(statePublisher: statePublisher, router: self)
        let controller = LogInViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }

    func signUp() {
        let router = SignUpRouter(
            parent: self,
            statePublisher: statePublisher,
            navigationController: navigationController
        )
        add(child: router)
    }
}
