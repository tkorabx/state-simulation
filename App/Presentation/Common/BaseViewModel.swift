import Foundation
import RxSwift

protocol BaseViewModelProtocol {

    var popUpAlert: Observable<String> { get }

    func buttonHasBeenSelected()
    func viewWillAppear()
    func viewWillDisappear()
    func backBarButtonSelected()
    func popUpActionHasBeenSelected()
}

class BaseViewModel: BaseViewModelProtocol {

    private(set) var bag: DisposeBag?

    private let statePublisher: StatePublisher
    private var currentState: StatePublisher.State?
    private let popUpAlertSubject = PublishSubject<String>()
    private let popUpAlertDismissed = PublishSubject<Void>()

    var popUpAlert: Observable<String> {
        popUpAlertSubject.asObservable()
    }

    init(statePublisher: StatePublisher) {
        self.statePublisher = statePublisher
    }

    func buttonHasBeenSelected() {
        if currentState == .established {
            popUpAlertSubject.on(.next(.messageSent))
        }
    }

    func popUpActionHasBeenSelected() {
        popUpAlertDismissed.onNext(())
    }

    func viewWillAppear() {
        let bag = DisposeBag()

        statePublisher
            .startObserving()
            .do(onNext: { [weak self] state in
                self?.currentState = state
            })
            .map { $0.title }
            .subscribe(popUpAlertSubject)
            .disposed(by: bag)

        Observable
            .combineLatest(
                popUpAlert,
                popUpAlertDismissed.asObservable()
            )
            .filter { message, _ in
                message == .messageSent
            }
            .subscribe(onNext: { [weak self] _ in
                self?.routeToNextScreen()
            })
            .disposed(by: bag)

        self.bag = bag
    }

    func viewWillDisappear() {
        bag = nil
    }

    func backBarButtonSelected() {
        assertionFailure("To implement by subclasses")
    }

    func routeToNextScreen() {
        // To implement by subclasses
    }
}

private extension StatePublisher.State {

    var title: String {
        switch self {
        case .error:
            return "Connection Error"
        case .connecting:
            return "Connecting"
        case .established:
            return "Connection Established"
        }
    }
}

private extension String {
    static let messageSent = "Message Sent"
}
