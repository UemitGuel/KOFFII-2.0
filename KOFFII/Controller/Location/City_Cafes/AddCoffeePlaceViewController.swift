import UIKit
import FirebaseFirestore
import SVProgressHUD

class AddCoffeePlaceViewController: UIViewController {

    @IBOutlet weak var coffeePlaceTextField: UITextField!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBOutlet weak var foodSwitch: UISwitch!
    @IBOutlet weak var veganSwitch: UISwitch!
    @IBOutlet weak var cakeSwitch: UISwitch!
    @IBOutlet weak var plugSwitch: UISwitch!
    
    @IBOutlet weak var note: UITextView!
    
    
    var db: Firestore!
    
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

    @IBAction func addCoffeePlaceButtonTapped(_ sender: UIButton) {
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = db.collection("AddedCoffeePlaces").addDocument(data: [
            "name": coffeePlaceTextField.text,
            "wifi": wifiSwitch.isOn,
            "food": foodSwitch.isOn,
            "vegan": veganSwitch.isOn,
            "cake": cakeSwitch.isOn,
            "plug": plugSwitch.isOn,
            "note": note.text
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
