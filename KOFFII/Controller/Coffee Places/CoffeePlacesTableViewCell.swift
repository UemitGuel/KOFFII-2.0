import UIKit

class CoffeePlacesTableViewCell: UITableViewCell {
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeImageView: UIImageView!

    static let cellId = "CoffeePLacesTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cafeImageView.layer.cornerRadius = 8
    }
}
