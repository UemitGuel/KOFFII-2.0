import FirebaseFirestore
import MapKit
import SVProgressHUD
import UIKit

class RoasterDetailViewController: UIViewController {
    @IBOutlet var map: MKMapView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!

    var passedRoastery: Roastery?
    let regionRadius: CLLocationDistance = 1000
    var roasteryName: String { return passedRoastery?.name ?? "" }
    var location: CLLocation {
        let latitude = passedRoastery?.latitude ?? 0
        let longitude = passedRoastery?.longitude ?? 0
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    var db: Firestore!
    let myGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        title = passedRoastery?.name
        MapFunctions().centerMapOnLocation(map: map, location: location)
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    @IBAction func openMapsButtonTapped(_: UIButton) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let actionsheet = MapFunctions().returnMapOptionsAlert(cafeName: roasteryName,
                                                                   latitude: latitude,
                                                                   longitude: longitude)
        present(actionsheet, animated: true, completion: nil)
    }
}
