import CoreLocation
import MapKit
import UIKit

class CafeDetailViewController: UIViewController {
    @IBOutlet var map: MKMapView!
    @IBOutlet var toLocationButton: UIButton!

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
    
    var passedCafe: CafeController.Cafe?
    var features: [String:Bool] { return passedCafe?.features ?? [:] }
    var cafeName: String { return passedCafe?.name ?? "" }
    var location: CLLocation {
        let latitude = passedCafe?.latitude ?? 0
        let longitude = passedCafe?.longitude ?? 0
        return CLLocation(latitude: latitude, longitude: longitude)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightButtons()
        MapFunctions().centerMapOnLocation(map: map, location: location)
        title = cafeName
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
