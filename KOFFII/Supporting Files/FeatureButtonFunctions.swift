import UIKit
import Foundation

class FeatureButtonFunctions {
    let buttonTappedColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
    let quicksandMediumFont = UIFont(name: "Quicksand-Medium", size: 15)
    let quicksandBoldFont = UIFont(name: "Quicksand-Bold", size: 15)    
    var features : [String:Bool] = [:]
    
    func highlightSingleButton(featureAsString: String,
                                        button: RoundButton,
                                        label: UILabel) {
        if features[featureAsString] == true {
            button.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            button.borderWidth = 2
            label.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
    }
    
    func handleButtonTap(userRequestedFeatures: inout [Features], feature: Features, button: RoundButton, label: UILabel) {
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
}
