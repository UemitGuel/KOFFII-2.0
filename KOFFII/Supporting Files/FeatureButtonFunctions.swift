import UIKit
import Foundation

class FeatureButttonFunctions {
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
}
