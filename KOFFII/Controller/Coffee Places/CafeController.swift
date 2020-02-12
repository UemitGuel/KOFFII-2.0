import UIKit
import MapKit

class CafeController {
    
    struct Cafe: Hashable {
        let name: String
        let latitude: Double?
        let longitude: Double?
        let locationURL: String?
        let features: [String: Bool]?
        let neighborhood: String?
        
        let mapView = MKMapView()
        
        var distanceUserToLocation: CLLocationDistance = 0
        
        mutating func changeUserDistanceToLocation(distanceUserToLocation: CLLocationDistance) {
            self.distanceUserToLocation = distanceUserToLocation
        }
        
        private let identifier: UUID
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.identifier)
        }
        static func == (lhs: Cafe, rhs: Cafe) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        func containsFeature(_ featureCase: Feature?) -> Bool {
            guard let featureCase = featureCase else { return true }
            return features![featureCase.rawValue] == true
        }
        
        func containsNeighborhood(_ neighborhoodCase: Neighborhood?) -> Bool {
            guard let neighborhoodCase = neighborhoodCase else { return true }
            return neighborhood == neighborhoodCase.rawValue
        }
        
        init?(dictionary: [String: Any]) {
            guard let name = dictionary["name"] as? String else { return nil }
            self.name = name
            
            latitude = dictionary["latitude"] as? Double
            longitude = dictionary["longitude"] as? Double
            locationURL = dictionary["locationURL"] as? String
            features = dictionary["features"] as? [String: Bool]
            neighborhood = dictionary["hood"] as? String
            self.identifier = UUID()
        }
    }
    
    var cafes = [Cafe]()
    
    func filteredCafes(userRequestedFeatures: [Feature],userChoosenNeighborhoods: [Neighborhood],with filter: String?=nil) -> [Cafe] {
        var filtered = cafes
        for userRequestedFeature in userRequestedFeatures {
            filtered = filtered.filter { $0.containsFeature(userRequestedFeature) }
        }
        for userChoosenNeighborhood in userChoosenNeighborhoods {
            filtered = filtered.filter { $0.containsNeighborhood(userChoosenNeighborhood)}
        }
        return filtered
    }
    
    func fetchAndConfigureUnfilteredCafes(completion: @escaping () -> Void) {
        Constants.refs.firestoreCologneCafes
            .getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        guard let cafe = CafeController.Cafe(dictionary: data) else { return }
                        self.cafes.append(cafe)
                    }
                    completion()
                }
        }
    }
}
