import CBFlashyTabBarController
import FirebaseCore
import FirebaseFirestore
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CBFlashyTabBar.appearance().tintColor = #colorLiteral(red: 0.7176470588, green: 0.1098039216, blue: 0.1098039216, alpha: 1)

        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db) // silence warning

        return true
    }
}
