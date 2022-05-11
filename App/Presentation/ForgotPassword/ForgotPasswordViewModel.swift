import Foundation

final class ForgotPasswordViewModel: BaseViewModel {

    weak var router: ForgotPasswordRouterProtocol?

    init(statePublisher: StatePublisher, router: ForgotPasswordRouterProtocol) {
        self.router = router
        super.init(statePublisher: statePublisher)
    }

    override func backBarButtonSelected() {
        router?.back()
    }
}
