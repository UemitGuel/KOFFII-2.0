import Foundation

struct User {
    let name: String
    let email: String
    let favCafes: Array<String>?
    
    init?(dictionary: [String: Any]) {
        self.favCafes = dictionary["favCafes"] as? Array<String>
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
