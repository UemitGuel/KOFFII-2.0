import FirebaseFirestore
import UIKit

class CafeViewController: UIViewController {
    
    enum Section: CaseIterable {
        case cafes
    }
    
    let cafeController = CafeController()
    var dataSource: UITableViewDiffableDataSource<Section, CafeController.Cafe>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, CafeController.Cafe>! = nil
    
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
    
    private var cafes = [CafeController.Cafe]()
    var cafeObjects = [CafeController.Cafe]()
    var filteredCafeObjects = [CafeController.Cafe]()
    var userRequestedFeatures: [Feature] = []
    var userChoosenNeighborhoods: [Neighborhood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        configureDataSource()
        tableView.delegate = self
        downloadCafes { cafeArray in
            self.cafes = cafeArray
            self.updateUI(animated: false)
        }
    }
    
    func setupViewController() {
        // eliminate 1pt line
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
    }
    
    func downloadCafes(completionHandler: @escaping ([CafeController.Cafe]) -> Void) {
        var cafeArray: [CafeController.Cafe] = []
        Constants.refs.firestoreCologneCafes
            .getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        guard let cafe = CafeController.Cafe(dictionary: data) else { return }
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
        updateUI()
    }
}

extension CafeViewController: UITableViewDelegate {
    
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        performSegue(withIdentifier: Constants.segues.citytoDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == Constants.segues.citytoDetail {
            let cityDetailVC = segue.destination as! CafeDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                cityDetailVC.passedCafeObject = cafes[indexPath.row]
            }
        }
    }
}

extension CafeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return neighborhoods.count
    }
    
}

extension CafeViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return neighborhoods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let featureBF = FeatureButtonFunctions()
        featureBF.filterForNeighborhoods(userChoosenNeighborhoods: &userChoosenNeighborhoods, selectedHood: neighborhoods[row])
        updateUI()
    }
    
}

extension CafeViewController {
    
    func configureDataSource() {
        self.dataSource = UITableViewDiffableDataSource
            <Section, CafeController.Cafe>(tableView: tableView) {
                (tableView: UITableView, indexPath: IndexPath, item: CafeController.Cafe) -> UITableViewCell? in
                
                guard let cafeCell = tableView.dequeueReusableCell(withIdentifier: CafeTableViewCell.cellId, for: indexPath) as? CafeTableViewCell else { fatalError("Cannot create new cell!") }
                
                cafeCell.selectionStyle = .none
                cafeCell.cafeNameLabel.text = item.name
                return cafeCell
        }
        self.dataSource.defaultRowAnimation = .fade
    }
    
    func updateUI(animated: Bool = true) {
        print(cafes)
        let filteredCafes = cafeController.filteredCafes(cafes: cafes, userRequestedFeatures: userRequestedFeatures, userChoosenNeighborhoods: userChoosenNeighborhoods).sorted { $0.name < $1.name }
        print(cafes)
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, CafeController.Cafe>()
        
        currentSnapshot.appendSections([.cafes])
        currentSnapshot.appendItems(filteredCafes, toSection: .cafes)
        self.dataSource.apply(currentSnapshot, animatingDifferences: animated)
    }
    
}
