import SVProgressHUD
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_: Bool) {
        super.viewDidAppear(true)

        checkIfUsernameAlreadyExists()
    }

    private func checkIfUsernameAlreadyExists() {
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        print(username)
        if !username.isEmpty {
            performSegue(withIdentifier: "Login to Start", sender: self)
            print("hieiehiheih")
        }
    }

    @IBAction func enterAppButtonTapped(_: UIButton) {
        UserDefaults.standard.set(usernameTextField.text, forKey: "username")
        performSegue(withIdentifier: "Login to Start", sender: self)
    }
    
}
