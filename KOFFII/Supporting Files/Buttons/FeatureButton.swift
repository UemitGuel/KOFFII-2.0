import UIKit

class FeatureButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        layer.borderWidth = 1
        self.traitCollection.performAsCurrent {
            self.layer.borderColor = UIColor.label.cgColor
        }
    }
}
