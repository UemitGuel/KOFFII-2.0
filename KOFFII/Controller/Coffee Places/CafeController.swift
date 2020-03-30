import RealmSwift

class CafeController {
        
    let realm = try! Realm()
    
    func filteredCafes(cafeList: [Cafe],userRequestedFeatures: [Feature],userChoosenNeighborhoods: [Neighborhood],with filter: String?=nil) -> [Cafe] {
        var filteredCafeList = cafeList
        for userRequestedFeature in userRequestedFeatures {
            filteredCafeList = cafeList.filter { $0.containsFeature(userRequestedFeature) }
        }
        for userChoosenNeighborhood in userChoosenNeighborhoods {
            filteredCafeList = cafeList.filter { $0.containsNeighborhood(userChoosenNeighborhood)}
        }
        return filteredCafeList
    }
}
