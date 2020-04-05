import RealmSwift
import CoreLocation

class Cafe: Object {
    @objc dynamic var name = ""
    @objc dynamic var locationURL: String = ""
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    
    @objc dynamic var wifi: Bool = true
    @objc dynamic var vegan: Bool = true
    @objc dynamic var food: Bool = true
    @objc dynamic var cake: Bool = true
    @objc dynamic var plug: Bool = true


    var features: [String: Bool] {
        return ["wifi": wifi, "vegan": vegan, "food": food, "cake": cake, "plugin": plug]
    }
    
    @objc dynamic var neighborhood = Neighborhood.belgisches.rawValue
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
        let features = cafe["features"] as! [String: Bool]
        self.wifi = features["wifi"]!
        self.vegan = features["vegan"]!
        self.food = features["food"]!
        self.cake = features["cake"]!
        self.plug = features["plugin"]!
        self.neighborhood = cafe["hood"] as! String
    }
    
    func containsFeature(_ featureCase: Feature?) -> Bool {
        guard let featureCase = featureCase else { return true }
        return features[featureCase.rawValue] == true
    }
    
    func containsNeighborhood(_ neighborhoodCase: Neighborhood?) -> Bool {
        guard let neighborhoodCase = neighborhoodCase else { return true }
        return neighborhood == neighborhoodCase.rawValue
    }
    
    func changeUserDistanceToLocation(distanceUserToLocation: CLLocationDistance) {
        self.distanceUserToLocation = distanceUserToLocation
    }
}
