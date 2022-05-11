import Foundation
import UIKit

class UINavigationControllerMock: UINavigationController {

    var pushedController: UIViewController?
    var didPop = false

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedController = viewController
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        didPop = true
        return nil
    }
}
