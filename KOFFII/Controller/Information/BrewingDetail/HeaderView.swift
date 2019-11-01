import UIKit

class HeaderView: UITableViewCell {
    @IBOutlet var quanLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var seperator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        seperator.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
