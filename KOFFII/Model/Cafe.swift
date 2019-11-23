import Foundation

struct Cafe {
    let name: String
    let latitude: Double?
    let longitude: Double?
    let locationURL: String?
    let features: [String: Bool]?
    let hood: String?

    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name

        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        locationURL = dictionary["locationURL"] as? String
        features = dictionary["features"] as? [String: Bool]
        hood = dictionary["hood"] as? String
    }
}

// MARK: - Neighborhoods Init
    var neighborhoods = [L10n.allNeighborhoods,"Deutz/Kalk","Lindenthal/Sülz", "Nippes", "Ehrenfeld","Südstadt","Innenstadt", "Belgisches Viertel", "Latin Quarter"]
