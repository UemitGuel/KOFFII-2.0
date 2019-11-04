import FirebaseFirestore
import SVProgressHUD
import UIKit

class AddCoffeePlaceViewController: UIViewController {
    @IBOutlet var coffeePlaceTextField: UITextField!

    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet var foodSwitch: UISwitch!
    @IBOutlet var veganSwitch: UISwitch!
    @IBOutlet var cakeSwitch: UISwitch!
    @IBOutlet var plugSwitch: UISwitch!
    
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
    }

    func setupFirebase() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }

    @IBAction func addCoffeePlaceButtonTapped(_: UIButton) {
        // Add a new document with a generated id.
        var ref: DocumentReference?
        ref = db.collection("AddedCoffeePlaces").addDocument(data: [
            "name": coffeePlaceTextField.text ?? "",
            "wifi": wifiSwitch.isOn,
            "food": foodSwitch.isOn,
            "vegan": veganSwitch.isOn,
            "cake": cakeSwitch.isOn,
            "plug": plugSwitch.isOn,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        SVProgressHUD.showSuccess(withStatus: "Coffee place sent for review!")
        dismiss(animated: true)
    }
}
