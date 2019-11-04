import FirebaseFirestore
import MapKit
import SVProgressHUD
import UIKit

class RoasterDetailViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!

    @IBOutlet var roasterCommentsTableView: UITableView!
    @IBOutlet var sendButton: UIButton!

    @IBOutlet var commentTextField: UITextField!
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
        centerMapOnLocation(location: location)
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    // Showing and handeling location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
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
