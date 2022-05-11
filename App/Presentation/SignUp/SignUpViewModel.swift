import Foundation

final class SignUpViewModel: BaseViewModel {

    weak var router: SignUpRouterProtocol?

    init(statePublisher: StatePublisher, router: SignUpRouterProtocol) {
        self.router = router
        super.init(statePublisher: statePublisher)
    }

    override func backBarButtonSelected() {
        router?.back()
    }

    override func routeToNextScreen() {
        router?.forgotPassword()
    }
}
