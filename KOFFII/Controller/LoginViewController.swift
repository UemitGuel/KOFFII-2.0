import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func enterAppButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(usernameTextField.text, forKey: "username")
    }
}

