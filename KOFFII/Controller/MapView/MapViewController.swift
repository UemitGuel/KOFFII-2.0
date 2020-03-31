import FirebaseFirestore
import UIKit
import MapKit
import CoreLocation
import RealmSwift

class MapViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        navigationItem.title = L10n.overview
        
        let cafes = realm.objects(Cafe.self)
        var cafeList = [Cafe]()
        cafeList.append(contentsOf: cafes)
        var cafeLocations: [CafeLocation] = []
        for cafe in cafeList {
            let cafeLocation = CafeLocation(title: cafe.name, coordinate: CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude))
            cafeLocations.append(cafeLocation)
        }
        mapView.addAnnotations(cafeLocations)
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
