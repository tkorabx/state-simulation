import Foundation
import RxSwift

final class LogInViewModel: BaseViewModel, LogInViewModelProtocol {

    weak var router: LogInRouterProtocol?

    private let commandsExecuter: CommandsExecuter

    init(
        statePublisher: StatePublisher,
        router: LogInRouterProtocol,
        commandsExecuter: CommandsExecuter = .init()
    ) {
        self.router = router
        self.commandsExecuter = commandsExecuter
        super.init(statePublisher: statePublisher)
    }

    func sendCommandsHasBeenSelected() {
        if let bag = bag {
            commandsExecuter
                .sendCommands()
                .subscribe(onNext: { value in
                    print("\(value)", Date())
                })
                .disposed(by: bag)
        } else {
            assertionFailure("bag should be set at this point")
        }
    }

    override func routeToNextScreen() {
        router?.signUp()
    }
}
