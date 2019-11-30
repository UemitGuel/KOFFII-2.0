import Foundation

struct Cafe: Hashable {
    let name: String
    let latitude: Double?
    let longitude: Double?
    let locationURL: String?
    let features: [String: Bool]?
    let hood: String?
    
    private let identifier: UUID
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }

    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name

        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        locationURL = dictionary["locationURL"] as? String
        features = dictionary["features"] as? [String: Bool]
        hood = dictionary["hood"] as? String
        self.identifier = UUID()
    }
}

// MARK: - Neighborhoods Init
    var neighborhoods = [L10n.allNeighborhoods,"Deutz/Kalk","Lindenthal/Sülz", "Nippes", "Ehrenfeld","Südstadt","Innenstadt", "Belgisches Viertel", "Latin Quarter"]
