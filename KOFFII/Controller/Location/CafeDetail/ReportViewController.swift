import UIKit
import FirebaseFirestore
import SVProgressHUD

class ReportViewController: UIViewController {

    var db: Firestore!
    var blockedUsers : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()

    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    @IBAction func reportButtonTapped(_ sender: UIButton) {
        // 1. Create the alert controller.
        let alert = UIAlertController(title: "Report User",
                                      message: "which user do you wanna report?",
                                      preferredStyle: .alert)

        // 2. Add the text field. You can configure it however you need.
        alert.addTextField { textField in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Report", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            // Add a new document with a generated id.
            let username = UserDefaults.standard.string(forKey: "username") ?? ""
            var ref: DocumentReference? = nil
            ref = self.db.collection("ReportedUsers").addDocument(data: [
                "from" : username,
                "username": textField?.text
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    SVProgressHUD.showSuccess(withStatus: "User has been reported")
                    self.dismiss(animated: true)
                }
            }
        }))

        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func hideContentButtonTapped(_ sender: UIButton) {
        // 1. Create the alert controller.
        let alert = UIAlertController(title: "Hide Content",
                                      message: "From which user do you want the content to be hidden?",
                                      preferredStyle: .alert)

        // 2. Add the text field. You can configure it however you need.
        alert.addTextField { textField in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Hide Content", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            // Add a new document with a generated id.
            let defaults = UserDefaults.standard
            self.blockedUsers = defaults.stringArray(forKey: "blockedUsers") ?? [String]()
            self.blockedUsers.append(textField?.text ?? "")
            defaults.set(self.blockedUsers, forKey: "blockedUsers")
            self.dismiss(animated: true) {
                SVProgressHUD.showSuccess(withStatus: "Content from this user will be hidden for you")
            }
        }))

        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
    }
    
}
