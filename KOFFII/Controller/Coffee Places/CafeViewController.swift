import FirebaseFirestore
import UIKit
import SwiftUI
import CoreLocation
import RealmSwift

class CafeViewController: UIViewController {
    
    let realm = try! Realm()
    let locationManager = CLLocationManager()

    let mapFunctions = MapHelper()
    var userLocationEnabled: Bool = false
    
    enum Section: CaseIterable {
        case cafes
    }
    
    var dataSource: UITableViewDiffableDataSource<Section, Cafe>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Cafe>! = nil
    
    @IBOutlet weak var addCoffeePlace: UIBarButtonItem!
    
    
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
    
    var userRequestedFeatures: [Feature] = []
    var userChoosenNeighborhoods: [Neighborhood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseService().fetchCafes {
            self.updateUI()
        }
        checkLocationServices()
        setupViewController()
        configureDataSource()
    }
    
    func setupViewController() {
        // eliminate 1pt line
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
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
        
    func filteredCafes(userRequestedFeatures: [Feature],userChoosenNeighborhoods: [Neighborhood],with filter: String?=nil) -> [Cafe] {
        let cafes = realm.objects(Cafe.self).sorted(byKeyPath: "name")
        var cafeList = [Cafe]()
        cafeList.append(contentsOf: cafes)
        for userRequestedFeature in userRequestedFeatures {
            cafeList = cafeList.filter { $0.containsFeature(userRequestedFeature) }
        }
        for userChoosenNeighborhood in userChoosenNeighborhoods {
            cafeList = cafeList.filter { $0.containsNeighborhood(userChoosenNeighborhood)}
        }
        return cafeList
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
                if let identifier = dataSource.itemIdentifier(for: indexPath) {
                    cityDetailVC.passedCafe = identifier
                }
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
            <Section, Cafe>(tableView: tableView) {
                (tableView: UITableView, indexPath: IndexPath, item: Cafe) -> UITableViewCell? in
                let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "DefaultCell")
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                cell.textLabel?.text = item.name
                cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
                if self.userLocationEnabled {
                    cell.detailTextLabel?.text = MapHelper.getDistanceAsStringRounded(latitude: item.latitude, longitude: item.longitude)
                } else {
                    cell.detailTextLabel?.text = item.neighborhood
                }
                cell.detailTextLabel?.textColor = .secondaryLabel
                cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
                cell.imageView?.image = UIImage(asset: Asset.coffeeIcon)
                return cell
        }
        self.dataSource.defaultRowAnimation = .fade
    }
    
    func updateUI(animated: Bool = true) {
        var cafeList = filteredCafes(userRequestedFeatures: userRequestedFeatures, userChoosenNeighborhoods: userChoosenNeighborhoods).sorted { $0.name < $1.name }
        if userLocationEnabled {
            cafeList = cafeList.sorted { MapHelper.getDistancefromUserToCafe(latitude: $0.latitude, longitude: $0.longitude)
                    < MapHelper.getDistancefromUserToCafe(latitude: $1.latitude, longitude: $1.longitude)
            }
        }
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, Cafe>()
        currentSnapshot.appendSections([.cafes])
        currentSnapshot.appendItems(cafeList, toSection: .cafes)
        self.dataSource.apply(currentSnapshot, animatingDifferences: animated)
    }
}


// MARK: LOCATIONMANAGER
extension CafeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            userLocationEnabled = false
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            userLocationEnabled = true
            break
        case .denied:
            userLocationEnabled = false
            //Show alert to turn on permission
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //Show alert parents denied this permission
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
}


