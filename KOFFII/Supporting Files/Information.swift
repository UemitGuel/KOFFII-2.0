import Foundation

struct Information {
    let name: String
    let imageName: String?
    let quan: String?
    let temp: String?
    let time: String?
    let tips: [String]?
    let complainCatgory: String?

    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name

        imageName = dictionary["imageName"] as? String
        quan = dictionary["quan"] as? String
        temp = dictionary["temp"] as? String
        time = dictionary["time"] as? String
        tips = dictionary["tips"] as? [String]
        complainCatgory = dictionary["complainCategory"] as? String
    }
}

