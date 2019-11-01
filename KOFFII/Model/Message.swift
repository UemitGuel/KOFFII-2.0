import Firebase
import Foundation

struct Message {
    let author: String
    let date: String?
    let message: String?
    let timeStamp: Timestamp?

    init?(dictionary: [String: Any]) {
        guard let author = dictionary["author"] as? String else { return nil }
        self.author = author

        date = dictionary["date"] as? String
        message = dictionary["message"] as? String
        timeStamp = dictionary["created"] as? Timestamp
    }
}
