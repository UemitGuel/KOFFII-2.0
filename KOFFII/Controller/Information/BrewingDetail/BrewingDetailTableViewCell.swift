import UIKit

class BrewingDetailTableViewCell: UITableViewCell {
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var longTextLabel: UILabel!

    static let cellId = "InformationDetailTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
