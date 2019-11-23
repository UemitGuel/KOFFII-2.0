import CoreLocation
import FirebaseFirestore
import MapKit
import UIKit

class CafeDetailViewController: UIViewController {
    @IBOutlet var map: MKMapView!
    @IBOutlet var toLocationButton: UIButton!

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

    var passedCafeObject: Cafe?
    var features: [String:Bool] { return passedCafeObject?.features ?? [:] }
    var cafeName: String { return passedCafeObject?.name ?? "" }
    var location: CLLocation {
        let latitude = passedCafeObject?.latitude ?? 0
        let longitude = passedCafeObject?.longitude ?? 0
        return CLLocation(latitude: latitude, longitude: longitude)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupButtons()
        highlightButtons()
        MapFunctions().centerMapOnLocation(map: map, location: location)
        title = cafeName
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
    
    @IBAction func openMapsButtonTapped(_ sender: UIButton) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let actionsheet = MapFunctions().returnMapOptionsAlert(cafeName: cafeName,
                                                                   latitude: latitude,
                                                                   longitude: longitude)
        present(actionsheet, animated: true, completion: nil)
    }
    
    // which buttons have to be highlighted (depending on the data in firestore)
    func highlightButtons() {
        let featureBF = FeatureButtonFunctions()
        featureBF.features = features
        featureBF.highlightSingleButton(featureAsString: "wifi", button: wifiButton, label: wifiLabel)
        featureBF.highlightSingleButton(featureAsString: "food", button: foodButton, label: foodLabel)
        featureBF.highlightSingleButton(featureAsString: "cake", button: cakeButton, label: cakeLabel)
        featureBF.highlightSingleButton(featureAsString: "vegan", button: veganButton, label: veganLabel)
        featureBF.highlightSingleButton(featureAsString: "plugin", button: plugButton, label: plugLabel)
    }
}
