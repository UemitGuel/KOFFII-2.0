import Firebase
import SVProgressHUD
import UIKit

class AddCafeViewController: UIViewController {
    @IBOutlet var coffeePlaceTextField: UITextField!

    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet var foodSwitch: UISwitch!
    @IBOutlet var veganSwitch: UISwitch!
    @IBOutlet var cakeSwitch: UISwitch!
    @IBOutlet var plugSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addCoffeePlaceButtonTapped(_: UIButton) {
        var ref: DocumentReference?
        ref = Constants.refs.firestoreAddCoffeeCollection
            .addDocument(data: [
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
        SVProgressHUD.showSuccess(withStatus: L10n.coffeePlaceSentForReview)
        dismiss(animated: true)
    }
}
