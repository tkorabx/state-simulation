import Foundation
import RxSwift

class StatePublisher {

    enum State: CaseIterable {
        case error
        case connecting
        case established
    }

    private var currentState = State.error
    private let scheduler: SchedulerType
    private let interval: DispatchTimeInterval

    private lazy var bag = DisposeBag()

    init(
        scheduler: SchedulerType = MainScheduler.instance,
        interval: DispatchTimeInterval = .seconds(5),
        // Used to keep Observable emitting every 5 seconds
        // Otherwise, it needs a subscription to start timer
        // true - for app,
        // false - for tests (prevents scheduler being blocked)
        shouldEmitAutomatically: Bool = true
    ) {
        self.scheduler = scheduler
        self.interval = interval

        if shouldEmitAutomatically {
            startObserving()
                .subscribe { _ in }
                .disposed(by: bag)
        }
    }

    private lazy var observable = Observable<Int>
        .interval(interval, scheduler: scheduler)
        .map { [unowned self] _ -> State in
            let newRandomValue = self.randomState()
            return newRandomValue
        }
        .do(onNext: { [unowned self] state in
            self.currentState = state
        })
        .share()

    func startObserving() -> Observable<State> {
        observable
    }

    private func randomState() -> State {
        var array = State.allCases
        array.removeAll(where: { $0 == currentState })
        return array.randomElement() ?? .error
    }
}
