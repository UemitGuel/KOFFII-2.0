import Foundation
import UIKit

@IBDesignable class RoundButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    func sharedInit() {
        refreshCorners(value: cornerRadius)
        refreshColor(color: customBGColor)
        refreshBorderColor(_colorBorder: customBorderColor)
        refreshBorder(_borderWidth: borderWidth)
        tintColor = .white
    }

    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }

    func createImage(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }

    func refreshColor(color: UIColor) {
        let image = createImage(color: color)
        setBackgroundImage(image, for: UIControl.State.normal)
        clipsToBounds = true
    }

    @IBInspectable var customBGColor: UIColor = UIColor(red: 0, green: 122 / 255.0, blue: 255 / 255.0, alpha: 1) {
        didSet {
            refreshColor(color: customBGColor)
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            refreshBorder(_borderWidth: borderWidth)
        }
    }

    func refreshBorder(_borderWidth: CGFloat) {
        layer.borderWidth = _borderWidth
    }

    @IBInspectable var customBorderColor: UIColor = UIColor(red: 0, green: 122 / 255, blue: 255 / 255, alpha: 1) {
        didSet {
            refreshBorderColor(_colorBorder: customBorderColor)
        }
    }

    func refreshBorderColor(_colorBorder: UIColor) {
        layer.borderColor = _colorBorder.cgColor
    }
}
