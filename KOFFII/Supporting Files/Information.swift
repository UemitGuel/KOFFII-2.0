import UIKit

struct Information {
    let name: String
    let image: UIImage
    let quan: String?
    let temp: String?
    let time: String?
    let tips: [String]
    let complainCategory: complainCategory?
    
    enum complainCategory {
        case coffee
        case espresso
    }
}

