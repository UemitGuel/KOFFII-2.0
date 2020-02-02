import UIKit

class FeatureButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.traitCollection.performAsCurrent {
            self.layer.borderColor = UIColor.label.cgColor
        }
        let blur = Constants.getBlur(view: self)
        self.insertSubview(blur, at: 0)
        if let imageView = self.imageView{
            self.bringSubviewToFront(imageView)
        }
    }
}
