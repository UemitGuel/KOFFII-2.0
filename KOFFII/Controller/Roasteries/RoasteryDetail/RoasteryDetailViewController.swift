import MapKit
import UIKit

class RoasteryDetailViewController: UIViewController {
    @IBOutlet var map: MKMapView!

    var passedRoastery: Roastery?
    var roasteryName: String { return passedRoastery?.name ?? "" }
    var location: CLLocation {
        let latitude = passedRoastery?.latitude ?? 0
        let longitude = passedRoastery?.longitude ?? 0
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = roasteryName
        MapFunctions().centerMapOnLocation(map: map, location: location)
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
