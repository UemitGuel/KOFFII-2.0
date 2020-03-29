import UIKit
import MapKit

class CafeController {
        
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
}
