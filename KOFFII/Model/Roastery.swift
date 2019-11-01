import Foundation

struct Roastery {
    let name: String
    let latitude: Double?
    let longitude: Double?
    let locationURL: String?

    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name

        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        locationURL = dictionary["locationURL"] as? String
    }
}
