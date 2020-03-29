import RealmSwift
import CoreLocation

class Cafe: Object {
    @objc dynamic var name = ""
    @objc dynamic var locationURL: String = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0

    var features: [String: Bool]?
    
    var neighborhood = Neighborhood.belgisches.rawValue
    var neighborhoodEnum: Neighborhood {
      get {
        return Neighborhood(rawValue: neighborhood)!
      }
      set {
        neighborhood = newValue.rawValue
      }
    }
    
    var distanceUserToLocation: CLLocationDistance = 0
    
    override static func primaryKey() -> String? {
        return "name"
    }

    convenience init(_ cafe: [String : Any]) {
        self.init()
        self.name = cafe["name"] as! String
        self.locationURL = cafe["locationURL"] as! String
        self.latitude = cafe["latitude"] as! Double
        self.longitude = cafe["longitude"] as! Double
        self.features = cafe["features"] as? [String: Bool]
        self.neighborhood = cafe["hood"] as! String
    }
    
    func containsFeature(_ featureCase: Feature?) -> Bool {
        guard let featureCase = featureCase else { return true }
        return features![featureCase.rawValue] == true
    }
    
    func containsNeighborhood(_ neighborhoodCase: Neighborhood?) -> Bool {
        guard let neighborhoodCase = neighborhoodCase else { return true }
        return neighborhood == neighborhoodCase.rawValue
    }
    
    func changeUserDistanceToLocation(distanceUserToLocation: CLLocationDistance) {
        self.distanceUserToLocation = distanceUserToLocation
    }
}

//struct Cafe: Hashable {
//    let name: String
//    let latitude: Double?
//    let longitude: Double?
//    let locationURL: String?
//    let features: [String: Bool]?
//    let neighborhood: String?
//
//    let mapView = MKMapView()
//
//    var distanceUserToLocation: CLLocationDistance = 0
//
//    mutating func changeUserDistanceToLocation(distanceUserToLocation: CLLocationDistance) {
//        self.distanceUserToLocation = distanceUserToLocation
//    }

//}
