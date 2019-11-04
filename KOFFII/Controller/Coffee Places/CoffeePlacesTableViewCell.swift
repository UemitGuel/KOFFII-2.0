import UIKit

class CoffeePlacesTableViewCell: UITableViewCell {
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cafeImageView.layer.cornerRadius = 8
    }
}
