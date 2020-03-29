import UIKit
import MapKit

class CafeController {
        
    func filteredCafes(cafeList: [Cafe],userRequestedFeatures: [Feature],userChoosenNeighborhoods: [Neighborhood],with filter: String?=nil) -> [Cafe] {
        var filteredCafeList = [Cafe]()
        for userRequestedFeature in userRequestedFeatures {
            filteredCafeList = cafeList.filter { $0.containsFeature(userRequestedFeature) }
        }
        for userChoosenNeighborhood in userChoosenNeighborhoods {
            filteredCafeList = cafeList.filter { $0.containsNeighborhood(userChoosenNeighborhood)}
        }
        return filteredCafeList
    }
}
