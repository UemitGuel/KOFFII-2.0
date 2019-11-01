import Foundation

struct Complain {
    let name: String
    let improvements: [String]?

    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name

        improvements = dictionary["improvements"] as? [String]
    }
}
