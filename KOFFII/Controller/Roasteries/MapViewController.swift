import FirebaseFirestore
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let cafeController = CafeController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center = CLLocationCoordinate2DMake(50.939506, 6.946490)
        let span = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        cafeController.fetchAndConfigureUnfilteredCafes {
            var cafeLocationArray: [CafeLocation] = []
            self.cafeController.cafes.forEach { cafe in
                cafeLocationArray.append(CafeLocation(title: cafe.name, coordinate: CLLocationCoordinate2D(latitude: cafe.latitude ?? 0, longitude: cafe.longitude ?? 0)))
            }
            self.mapView.addAnnotations(cafeLocationArray)

        }
    }
    
}

class CafeLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
