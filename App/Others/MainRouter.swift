import UIKit

protocol MainRouterProtocol: RouterProtocol {
    func logIn()
}

final class MainRouter: MainRouterProtocol {

    weak var parent: RouterProtocol?

    var children: [RouterProtocol] = []

    let window: UIWindow
    let statePublisher: StatePublisher
    let navigationController = UINavigationController()

     init(statePublisher: StatePublisher, window: UIWindow) {
         self.statePublisher = statePublisher
         self.window = window
    }

    func start() {
        window.rootViewController = navigationController
    }

    func logIn() {
        let router = LogInRouter(
            statePublisher: statePublisher,
            navigationController: navigationController
        )
        add(child: router)
    }
}
