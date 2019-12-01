import FirebaseFirestore
import UIKit

class CoffeePlacesViewController: UIViewController {
    
    enum Section: CaseIterable {
        case cafes
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, Cafe>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Cafe>! = nil
    static let reuseIdentifier = "reuse-identifier"
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var hoodPickerView: UIPickerView!
    
    @IBOutlet var wifiButton: FeatureButton!
    @IBOutlet var wifiLabel: UILabel!
    
    @IBOutlet var foodButton: FeatureButton!
    @IBOutlet var foodLabel: UILabel!
    
    @IBOutlet var veganButton: FeatureButton!
    @IBOutlet var veganLabel: UILabel!
    
    @IBOutlet var cakeButton: FeatureButton!
    @IBOutlet var cakeLabel: UILabel!
    
    @IBOutlet var plugButton: FeatureButton!
    @IBOutlet var plugLabel: UILabel!
    
    var cafeObjects = [Cafe]()
    var filteredCafeObjects = [Cafe]()
    var userRequestedFeatures: [Feature] = []
    var userChoosenNeighborhoods: [Neighborhood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        configureDataSource()
        tableView.delegate = self
        downloadCafes { cafeArray in
            self.cafeObjects = cafeArray
            self.cafeObjects = self.cafeObjects.sorted(by: { $0.name < $1.name })
            self.filteredCafeObjects = self.filteredCafeObjects.sorted(by: { $0.name < $1.name })
            self.updateUI(animated: false)
        }
    }
    
    func setupViewController() {
        // eliminate 1pt line
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
    }
    
    func downloadCafes(completionHandler: @escaping ([Cafe]) -> Void) {
        var cafeArray: [Cafe] = []
        Constants.refs.firestoreCologneCafes
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
        updateUI()
    }
}

extension CoffeePlacesViewController: UITableViewDelegate {
    
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        performSegue(withIdentifier: Constants.segues.citytoDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == Constants.segues.citytoDetail {
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
    }
    
}

extension CoffeePlacesViewController {
    
    func configureDataSource() {
        self.dataSource = UITableViewDiffableDataSource
            <Section, Cafe>(tableView: tableView) {
                (tableView: UITableView, indexPath: IndexPath, item: Cafe) -> UITableViewCell? in
                
                guard let cafeCell = tableView.dequeueReusableCell(withIdentifier: CoffeePlacesTableViewCell.cellId, for: indexPath) as? CoffeePlacesTableViewCell else { fatalError("Cannot create new cell!") }
                
                cafeCell.selectionStyle = .none
                cafeCell.cafeNameLabel.text = item.name
                return cafeCell
        }
        self.dataSource.defaultRowAnimation = .fade
    }
    
    func updateUI(animated: Bool = true) {
        
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, Cafe>()
        
        currentSnapshot.appendSections([.cafes])
        print(self.isFiltering())
        if self.isFiltering() {
            currentSnapshot.appendItems(filteredCafeObjects, toSection: .cafes)
        } else {
            currentSnapshot.appendItems(cafeObjects, toSection: .cafes)
        }
        print(filteredCafeObjects)
        print(cafeObjects)
        self.dataSource.apply(currentSnapshot, animatingDifferences: animated)
    }
    
}
