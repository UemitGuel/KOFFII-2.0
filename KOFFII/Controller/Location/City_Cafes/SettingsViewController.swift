import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var termsConditionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termsConditionsTextView.isHidden = true
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        self.usernameLabel.text = username
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        // 1. Create the alert controller.
        let alert = UIAlertController(title: "Change Username", message: "enter your new username", preferredStyle: .alert)

        // 2. Add the text field. You can configure it however you need.
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        alert.addTextField { textField in
            textField.text = username
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "")")
            UserDefaults.standard.set(textField?.text, forKey: "username")
            let username = UserDefaults.standard.string(forKey: "username") ?? ""
            self.usernameLabel.text = username
        }))

        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func termsButtonTapped(_ sender: UIButton) {
        termsConditionsTextView.isHidden = false
    }
    
    
}
