import Firebase
import FirebaseFirestore
import SVProgressHUD
import UIKit

// Needed to compare requested Features, so what the users clicked, and the actual value inside the data
enum Features {
    case wifi
    case food
    case vegan
    case cake
    case plug
}

class CoffeePlacesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    @IBOutlet var wifiButton: RoundButton!
    @IBOutlet var wifiLabel: UILabel!

    @IBOutlet var foodButton: RoundButton!
    @IBOutlet var foodLabel: UILabel!

    @IBOutlet var veganButton: RoundButton!
    @IBOutlet var veganLabel: UILabel!

    @IBOutlet var cakeButton: RoundButton!
    @IBOutlet var cakeLabel: UILabel!

    @IBOutlet var plugButton: RoundButton!
    @IBOutlet var plugLabel: UILabel!

    var db: Firestore!
    let myGroup = DispatchGroup()

    let buttonTappedColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
    let quicksandMediumFont = UIFont(name: "Quicksand-Medium", size: 15)
    let quicksandBoldFont = UIFont(name: "Quicksand-Bold", size: 15)

    var cafeObjects = [Cafe]()
    var filteredCafeObjects = [Cafe]()
    var requestedFeatures: [Features] = []
    var passedCityName = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupViewController()

        downloadCafes { cafeArray in
            self.cafeObjects = cafeArray
            self.cafeObjects = self.cafeObjects.sorted(by: { $0.name < $1.name })
            self.filteredCafeObjects = self.filteredCafeObjects.sorted(by: { $0.name < $1.name })
            self.tableView.reloadData()
        }
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    func setupViewController() {
        // eliminate 1pt line
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    func downloadCafes(completionHandler: @escaping ([Cafe]) -> Void) {
        var cafeArray: [Cafe] = []
        db.collection("City").document("Cologne")
            .collection("Cafes")
            .getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        guard let cafe = Cafe(dictionary: data) else { return }
                        print("add cafe \(cafe)")
                        cafeArray.append(cafe)
                    }
                    completionHandler(cafeArray)
                }
            }
    }

    // Handling what happens when Feature Buttons get clicked
    @IBAction func wifiButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.wifi) {
            requestedFeatures.append(.wifi)
            buttonTappedAction(button: wifiButton, label: wifiLabel)
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .wifi }
            buttonUnTappedAction(button: wifiButton, label: wifiLabel)
        }
    }

    @IBAction func foodButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.food) {
            requestedFeatures.append(.food)
            buttonTappedAction(button: foodButton, label: foodLabel)
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .food }
            buttonUnTappedAction(button: foodButton, label: foodLabel)
        }
    }

    @IBAction func veganButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.vegan) {
            requestedFeatures.append(.vegan)
            buttonTappedAction(button: veganButton, label: veganLabel)
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .vegan }
            buttonUnTappedAction(button: veganButton, label: veganLabel)
        }
    }

    @IBAction func cakeButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.cake) {
            requestedFeatures.append(.cake)
            buttonTappedAction(button: cakeButton, label: cakeLabel)
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .cake }
            buttonUnTappedAction(button: cakeButton, label: cakeLabel)
        }
    }

    @IBAction func plugButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.plug) {
            requestedFeatures.append(.plug)
            buttonTappedAction(button: plugButton, label: plugLabel)
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .plug }
            buttonUnTappedAction(button: plugButton, label: plugLabel)
        }
    }

    private func buttonTappedAction(button: RoundButton, label: UILabel) {
        button.customBGColor = buttonTappedColor
        button.borderWidth = 2
        label.font = quicksandBoldFont

        filtering()
        tableView.reloadData()
    }
    
    private func buttonUnTappedAction(button: RoundButton, label: UILabel) {
        button.customBGColor = .white
        button.borderWidth = 1
        label.font = quicksandMediumFont

        filtering()
        tableView.reloadData()
    }

    // Active Filtering, if feature buttons are clicked
    func isFiltering() -> Bool {
        return !requestedFeatures.isEmpty
    }

    func filtering() {
        filteredCafeObjects = cafeObjects
        if requestedFeatures.contains(.wifi) {
            filteredCafeObjects = filteredCafeObjects.filter { $0.features!["wifi"] == true }
        }
        if requestedFeatures.contains(.food) {
            filteredCafeObjects = filteredCafeObjects.filter { $0.features!["food"] == true }
        }
        if requestedFeatures.contains(.vegan) {
            filteredCafeObjects = filteredCafeObjects.filter { $0.features!["vegan"] == true }
        }
        if requestedFeatures.contains(.cake) {
            filteredCafeObjects = filteredCafeObjects.filter { $0.features!["cake"] == true }
        }
        if requestedFeatures.contains(.plug) {
            filteredCafeObjects = filteredCafeObjects.filter { $0.features!["plugin"] == true }
        }
    }
}

extension CoffeePlacesViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if isFiltering() {
            return filteredCafeObjects.count
        } else {
            return cafeObjects.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeePLacesTableViewCell", for: indexPath) as! CoffeePlacesTableViewCell
        cell.selectionStyle = .none

        if isFiltering() {
            cell.cafeNameLabel.text = filteredCafeObjects[indexPath.row].name
        } else {
            cell.cafeNameLabel.text = cafeObjects[indexPath.row].name
        }
        return cell
    }
}

extension CoffeePlacesViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 93
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        performSegue(withIdentifier: "fromCitytoDetailSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "fromCitytoDetailSegue" {
            let cityDetailVC = segue.destination as! CafeDetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                if isFiltering() {
                    cityDetailVC.passedCafeObject = filteredCafeObjects[indexPath.row]
                } else {
                    cityDetailVC.passedCafeObject = cafeObjects[indexPath.row]
                }
            }
        }
    }
}
