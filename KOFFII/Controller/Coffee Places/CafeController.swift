import RealmSwift

class CafeController {
        
    let realm = try! Realm()
    
    func filteredCafes(userRequestedFeatures: [Feature],userChoosenNeighborhoods: [Neighborhood],with filter: String?=nil) -> [Cafe] {
        let cafes = realm.objects(Cafe.self).sorted(byKeyPath: "name")
        var cafeList = [Cafe]()
        cafeList.append(contentsOf: cafes)
        for userRequestedFeature in userRequestedFeatures {
            cafeList = cafeList.filter { $0.containsFeature(userRequestedFeature) }
        }
        for userChoosenNeighborhood in userChoosenNeighborhoods {
            cafeList = cafeList.filter { $0.containsNeighborhood(userChoosenNeighborhood)}
        }
        return cafeList
    }
}
