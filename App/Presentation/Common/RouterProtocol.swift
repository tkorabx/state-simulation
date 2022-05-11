import Foundation

protocol RouterProtocol: AnyObject {

    var parent: RouterProtocol? { get set }
    var children: [RouterProtocol] { get set }

    func start()
    func add(child: RouterProtocol)
    func remove(child: RouterProtocol)
}

extension RouterProtocol {

    func add(child: RouterProtocol) {
        child.start()
        children.append(child)
    }

    func remove(child: RouterProtocol) {
        children.removeAll(where: { $0 === child })
    }
}
