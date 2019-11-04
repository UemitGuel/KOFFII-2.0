import CoreLocation
import FirebaseFirestore
import MapKit
import SVProgressHUD
import UIKit

class CafeDetailViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var map: MKMapView!
    @IBOutlet var toLocationButton: UIButton!

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

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    var db: Firestore!
    let myGroup = DispatchGroup()

    var passedCafeObject: Cafe?
    var cafeName: String { return passedCafeObject?.name ?? "" }
    var location: CLLocation {
        let latitude = passedCafeObject?.latitude ?? 0
        let longitude = passedCafeObject?.longitude ?? 0
        return CLLocation(latitude: latitude, longitude: longitude)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        activateButtons()
        MapFunctions().centerMapOnLocation(map: map, location: location)
        title = passedCafeObject?.name
    }
    
    @IBAction func openMapsButtonTapped(_ sender: UIButton) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let actionsheet = MapFunctions().returnMapOptionsAlert(cafeName: cafeName,
                                                                   latitude: latitude,
                                                                   longitude: longitude)
        present(actionsheet, animated: true, completion: nil)
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    // which buttons have to be highlighted (depending on the data in firestore)
    func activateButtons() {
        if passedCafeObject?.features!["wifi"] == true {
            wifiButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            wifiButton.borderWidth = 2
            wifiLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["food"] == true {
            foodButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            foodButton.borderWidth = 2
            foodLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["vegan"] == true {
            veganButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            veganButton.borderWidth = 2
            veganLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["cake"] == true {
            cakeButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            cakeButton.borderWidth = 2
            cakeLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["plugin"] == true {
            plugButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            plugButton.borderWidth = 2
            plugLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
    }


}
