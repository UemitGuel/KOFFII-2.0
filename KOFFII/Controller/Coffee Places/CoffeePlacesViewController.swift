import Firebase
import FirebaseFirestore
import SVProgressHUD
import UIKit

class CoffeePlacesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var hoodPickerView: UIPickerView!
    
    @IBOutlet var wifiButton: UIButton!
    @IBOutlet var wifiLabel: UILabel!
    
    @IBOutlet var foodButton: UIButton!
    @IBOutlet var foodLabel: UILabel!
    
    @IBOutlet var veganButton: UIButton!
    @IBOutlet var veganLabel: UILabel!
    
    @IBOutlet var cakeButton: UIButton!
    @IBOutlet var cakeLabel: UILabel!
    
    @IBOutlet var plugButton: UIButton!
    @IBOutlet var plugLabel: UILabel!
    
    var db: Firestore!
    let myGroup = DispatchGroup()
    
    var cafeObjects = [Cafe]()
    var filteredCafeObjects = [Cafe]()
    var userRequestedFeatures: [Feature] = []
    var userChoosenNeighborhoods: [Neighborhood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupButtons()
        setupViewController()
        
        downloadCafes { cafeArray in
            self.cafeObjects = cafeArray
            self.cafeObjects = self.cafeObjects.sorted(by: { $0.name < $1.name })
            self.filteredCafeObjects = self.filteredCafeObjects.sorted(by: { $0.name < $1.name })
            self.tableView.reloadData()
        }
    }
    
    func setupFirebase() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func setupButtons() {
        wifiButton.layer.borderWidth = 1
        wifiButton.layer.borderColor = UIColor.label.cgColor
        wifiButton.layer.borderWidth = 1
        foodButton.layer.borderColor = UIColor.label.cgColor
        foodButton.layer.borderWidth = 1
        veganButton.layer.borderColor = UIColor.label.cgColor
        veganButton.layer.borderWidth = 1
        cakeButton.layer.borderColor = UIColor.label.cgColor
        cakeButton.layer.borderWidth = 1
        plugButton.layer.borderColor = UIColor.label.cgColor
        plugButton.layer.borderWidth = 1
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
                        cafeArray.append(cafe)
                    }
                    completionHandler(cafeArray)
                }
        }
    }
    
    @IBAction func featureButtonTapped(_ sender: UIButton) {
        let featureBF = FeatureButtonFunctions()
        switch sender {
        case wifiButton:
            featureBF.handleButtonTap(userRequestedFeatures: &userRequestedFeatures,
                                      feature: .wifi, button: wifiButton, label: wifiLabel)
        case foodButton:
            featureBF.handleButtonTap(userRequestedFeatures: &userRequestedFeatures,
                                      feature: .food, button: foodButton, label: foodLabel)
        case veganButton:
            featureBF.handleButtonTap(userRequestedFeatures: &userRequestedFeatures,
                                      feature: .vegan, button: veganButton, label: veganLabel)
        case cakeButton:
            featureBF.handleButtonTap(userRequestedFeatures: &userRequestedFeatures,
                                      feature: .cake, button: cakeButton, label: cakeLabel)
        case plugButton:
            featureBF.handleButtonTap(userRequestedFeatures: &userRequestedFeatures,
                                      feature: .plugin, button: plugButton, label: plugLabel)
        default:
            break
        }
        filtering()
        tableView.reloadData()
    }
    
    // Active Filtering, if feature buttons are clicked
    func isFiltering() -> Bool {
        return !userRequestedFeatures.isEmpty || !userChoosenNeighborhoods.isEmpty
    }
    
    func filtering() {
        filteredCafeObjects = cafeObjects
        for feature in Feature.allCases {
            if userRequestedFeatures.contains(feature) {
                filteredCafeObjects = filteredCafeObjects.filter { $0.features![feature.rawValue] == true }
            }
        }
        for neighborhood in Neighborhood.allCases {
            if userChoosenNeighborhoods.contains(neighborhood) {
                filteredCafeObjects = filteredCafeObjects.filter { $0.hood == neighborhood.rawValue }
            }
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CoffeePLacesTableViewCell",for: indexPath)
            as? CoffeePlacesTableViewCell else {
                return UITableViewCell()
        }
        
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

extension CoffeePlacesViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return neighborhoods.count
    }
    
}

extension CoffeePlacesViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return neighborhoods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let featureBF = FeatureButtonFunctions()
        featureBF.filterForNeighborhoods(userChoosenNeighborhoods: &userChoosenNeighborhoods, selectedHood: neighborhoods[row])
        filtering()
        tableView.reloadData()
    }
    
}
