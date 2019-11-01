import UIKit

class CoffeePlacesTableViewCell: UITableViewCell {
    @IBOutlet var cafeNameLabel: UILabel!

    @IBOutlet var cafeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cafeImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
