import Foundation

struct User {
    let name: String
    let email: String
    let favCafes: [String]?

    init?(dictionary: [String: Any]) {
        favCafes = dictionary["favCafes"] as? [String]
        name = dictionary["name"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
    }
}
