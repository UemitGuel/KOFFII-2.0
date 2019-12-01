import UIKit

class CafeTableViewCell: UITableViewCell {
    @IBOutlet var cafeNameLabel: UILabel!
    @IBOutlet var cafeImageView: UIImageView!

    static let cellId = "CafeTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cafeImageView.layer.cornerRadius = 8
    }
}
