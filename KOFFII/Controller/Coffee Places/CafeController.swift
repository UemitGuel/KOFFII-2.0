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
        
        var distanceUserToLocation: CLLocationDistance {
            //            let userLocation = MKMapPoint(mapView.userLocation.coordinate)
            let userLocation = MKMapPoint(CLLocationCoordinate2DMake(50.950268, 6.921078))
            let cafeLocation = MKMapPoint(CLLocationCoordinate2DMake(latitude ?? 0, longitude ?? 0))
            let distance = userLocation.distance(to: cafeLocation)
            return distance
        }
        
        var distanceMappedForDisplay: String {
            return mapDistanceForDisplay(distanceUserToLocation)
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
        
        func mapDistanceForDisplay(_ distance: CLLocationDistance) -> String {
            if distance < 100 {
                return "100 m"
            } else if distance < 200 {
                return "200 m"
            } else if distance < 300 {
                return "300 m"
            } else if distance < 400 {
                return "400 m"
            } else if distance < 500 {
                return "500 m"
            } else if distance < 600 {
                return "600 m"
            } else if distance < 700 {
                return "700 m"
            } else if distance < 800 {
                return "800 m"
            } else if distance < 900 {
                return "900 m"
            } else if distance < 1000 {
                return "1 km"
            } else if distance < 1200 {
                return "1.2 km"
            } else if distance < 1500 {
                return "1.5 km"
            } else if distance < 2000 {
                return "2 km"
            } else if distance < 5000 {
                return "5km"
            } else if distance < 10000 {
                return "10km"
            } else {
                return "+10km"
            }
            
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
