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

    var db: Firestore!
    let myGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        title = passedRoastery?.name

        // set map
        let location = CLLocation(latitude: passedRoastery?.latitude ?? 0, longitude: passedRoastery?.longitude ?? 0)
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
        let actionSheet = UIAlertController(title: "Open Location",
                                            message: "How you want to open?",
                                            preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let splitetStringName = passedRoastery?.name.components(separatedBy: " ")
        guard let nameJoined = splitetStringName!
            .joined(separator: "+")
            .addingPercentEncoding(withAllowedCharacters:
                .urlHostAllowed)
        else {
            fatalError("Hotelname not found")
        }
        let latitude = String(format: "%.6f", (passedRoastery?.latitude)!)
        let longitude = String(format: "%.6f", (passedRoastery?.longitude)!)

        // Google Maps
        let modeGM = "directionsmode=driving"
        let actionGoogleMaps = UIAlertAction(title: "Google Maps", style: .default) { _ in

            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                // ?q=Pizza&center=37.759748,-122.427135
                let url = URL(string: "comgooglemaps://?daddr=\(nameJoined)&center=\(latitude),\(longitude)&\(modeGM)")!
                print(url)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://")
            }
        }
        // Apple Maps
        let modeAM = "dirflg=c" // c=car
        let actionAppleMaps = UIAlertAction(title: "Apple Maps", style: .default) { _ in
            let coreUrl = "http://maps.apple.com/?"
            guard let url = URL(string: coreUrl +
                "q=\(nameJoined)&sll=" +
                latitude + "," + longitude +
                "&\(modeAM)&t=s")
            else {
                return print("error")
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        actionSheet.addAction(actionGoogleMaps)
        actionSheet.addAction(actionAppleMaps)
        actionSheet.addAction(actionCancel)
        present(actionSheet, animated: true, completion: nil)
    }
}
