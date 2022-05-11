import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainRouter: MainRouterProtocol?
    let statePublisher = StatePublisher()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }

    private func configureWindow() {
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        window.makeKeyAndVisible()

        mainRouter = MainRouter(statePublisher: statePublisher, window: window)
        mainRouter?.start()
        mainRouter?.logIn()

        self.window = window
    }
}
