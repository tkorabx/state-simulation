import Foundation
import RxSwift

class CommandsExecuter {

    // Helper property to add a prefix before number in console e.g. 1.x where x is number (id)
    // since app allows Send Commands Button multiple selection
    private var sendCommandsActionId = 0
    private let scheduler: SchedulerType
    private let queue: DispatchQueue

    init(scheduler: SchedulerType? = nil) {
        let queue = DispatchQueue(label: "commands.executer.queue")
        self.queue = queue
        self.scheduler = SerialDispatchQueueScheduler(queue: queue, internalSerialQueueName: "commands.executer.queue")
    }

    func sendCommands() -> Observable<String> {
        sendCommandsActionId += 1

        let ids = Array(1...10).map {
            ($0, "\(self.sendCommandsActionId).\($0)")
        }

        let observables = ids.map { number, message in
            Observable<String>.create { observer in
                self.scheduler.scheduleRelative(message, dueTime: .seconds(number)) { value in
                    observer.onNext(value)
                    observer.onCompleted()
                    return Disposables.create()
                }
            }
        }

        return Observable.concat(observables)
    }
}
