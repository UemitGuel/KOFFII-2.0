import CBFlashyTabBarController
import FirebaseCore
import FirebaseFirestore
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        CBFlashyTabBar.appearance().tintColor = .systemRed

        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db) // silence warning

        return true
    }
}
