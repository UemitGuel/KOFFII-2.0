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
    @IBOutlet var usernameOutlet: UIBarButtonItem!

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
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        usernameOutlet.title = username
    }

    func downloadCafes(completionHandler: @escaping ([Cafe]) -> Void) {
        var cafeArray: [Cafe] = []
        db.collection("City")
            .document("Cologne")
            .collection("Cafes")
            .getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let d = document.data()
                        guard let cafe = Cafe(dictionary: d) else { return }
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

            wifiButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            wifiButton.borderWidth = 2
            wifiLabel.font = UIFont(name: "Quicksand-Bold", size: 15)

            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .wifi }

            wifiButton.customBGColor = UIColor.white
            wifiButton.borderWidth = 1
            wifiLabel.font = UIFont(name: "Quicksand-Medium", size: 15)

            filtering()
            tableView.reloadData()
        }
    }

    @IBAction func foodButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.food) {
            requestedFeatures.append(.food)

            foodButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            foodButton.borderWidth = 2
            foodLabel.font = UIFont(name: "Quicksand-Bold", size: 15)

            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .food }

            foodButton.customBGColor = UIColor.white
            foodButton.borderWidth = 1
            foodLabel.font = UIFont(name: "Quicksand-Medium", size: 15)

            filtering()
            tableView.reloadData()
        }
    }

    @IBAction func veganButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.vegan) {
            requestedFeatures.append(.vegan)

            veganButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            veganButton.borderWidth = 2
            veganLabel.font = UIFont(name: "Quicksand-Bold", size: 15)

            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .vegan }

            veganButton.customBGColor = UIColor.white
            veganButton.borderWidth = 1
            veganLabel.font = UIFont(name: "Quicksand-Medium", size: 15)

            filtering()
            tableView.reloadData()
        }
    }

    @IBAction func cakeButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.cake) {
            requestedFeatures.append(.cake)

            cakeButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            cakeButton.borderWidth = 2
            cakeLabel.font = UIFont(name: "Quicksand-Bold", size: 15)

            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .cake }

            cakeButton.customBGColor = UIColor.white
            cakeButton.borderWidth = 1
            cakeLabel.font = UIFont(name: "Quicksand-Medium", size: 15)

            filtering()
            tableView.reloadData()
        }
    }

    @IBAction func plugButtonTapped(_: UIButton) {
        if !requestedFeatures.contains(.plug) {
            requestedFeatures.append(.plug)

            plugButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            plugButton.borderWidth = 2
            plugLabel.font = UIFont(name: "Quicksand-Bold", size: 15)

            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter { $0 != .plug }

            plugButton.customBGColor = UIColor.white
            plugButton.borderWidth = 1
            plugLabel.font = UIFont(name: "Quicksand-Medium", size: 15)

            filtering()
            tableView.reloadData()
        }
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

    @IBAction func editButtonTapped(_: UIBarButtonItem) {
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
            self.usernameOutlet.title = username
        }))

        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
    }

    @IBAction func addPlaceButtonTapped(_: UIBarButtonItem) {}
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
