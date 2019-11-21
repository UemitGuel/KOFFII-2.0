import UIKit
import Foundation

enum Neighborhood: String, CaseIterable {
    case deutz = "Deutz/Kalk"
    case lindenthal = "Lindenthal/Sülz"
    case nippes = "Nippes"
    case ehrenfeld = "Ehrenfeld"
    case südstadt = "Südstadt"
    case innenstadt = "Innenstadt"
    case belgisches = "Belgisches Viertel"
    case latin = "Latin Quarter"
}

// Needed to compare requested Features, so what the users clicked, and the actual value inside the data
enum Feature: String, CaseIterable {
    case wifi = "wifi"
    case food = "food"
    case vegan = "vegan"
    case cake = "cake"
    case plugin = "plugin"
}


class FeatureButtonFunctions {
    let buttonTappedColor = UIColor.systemGray2
    let quicksandMediumFont = UIFont(name: "Quicksand-Medium", size: 15)
    let quicksandBoldFont = UIFont(name: "Quicksand-Bold", size: 15)    
    var features : [String:Bool] = [:]
    
    func highlightSingleButton(featureAsString: String,
                                        button: RoundButton,
                                        label: UILabel) {
        if features[featureAsString] == true {
            button.customBGColor = buttonTappedColor
            button.borderWidth = 2
            label.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
    }
    
    func handleButtonTap(userRequestedFeatures: inout [Feature], feature: Feature, button: RoundButton, label: UILabel) {
        if !userRequestedFeatures.contains(feature) {
            userRequestedFeatures.append(feature)
            button.customBGColor = buttonTappedColor
            button.borderWidth = 2
            label.font = quicksandBoldFont
        } else {
            userRequestedFeatures = userRequestedFeatures.filter{ $0 != feature }
            button.customBGColor = .white
            button.borderWidth = 1
            label.font = quicksandMediumFont
        }
    }
    
    func filterForNeighborhoods(userChoosenNeighborhoods: inout [Neighborhood], selectedHood: String = "") {
        for neigbhorhood in Neighborhood.allCases {
            if selectedHood == neigbhorhood.rawValue {
                userChoosenNeighborhoods.append(neigbhorhood)
            } else {
                userChoosenNeighborhoods = userChoosenNeighborhoods.filter{ $0 != neigbhorhood }
            }
        }
    }
}
