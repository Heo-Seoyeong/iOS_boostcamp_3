import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let rootVC = MainTabbarVC()
        let naviVC = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = naviVC
        self.window?.makeKeyAndVisible()

        return true
    }

}

