import FirebaseFirestore
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let cafeController = CafeController()
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()

        cafeController.fetchAndConfigureUnfilteredCafes {
            var cafeLocationArray: [CafeLocation] = []
            self.cafeController.cafes.forEach { cafe in
                cafeLocationArray.append(CafeLocation(title: cafe.name, coordinate: CLLocationCoordinate2D(latitude: cafe.latitude ?? 0, longitude: cafe.longitude ?? 0)))
            }
            self.mapView.addAnnotations(cafeLocationArray)
            
        }
    }
    
    func centerViewInUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func centerViewInCologne() {
        let center = CLLocationCoordinate2DMake(50.939506, 6.946490)
        let span = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
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
            
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewInUserLocation()
            break
        case .denied:
            centerViewInCologne()
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

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
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
