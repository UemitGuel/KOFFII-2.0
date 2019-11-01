import UIKit

class InformationDetailTableViewCell: UITableViewCell {
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var longTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
