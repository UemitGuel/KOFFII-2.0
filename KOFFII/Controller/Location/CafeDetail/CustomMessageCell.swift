import UIKit

class CustomMessageCell: UITableViewCell {
    @IBOutlet var rightSideConstraint: NSLayoutConstraint!

    @IBOutlet var leftSideContraint: NSLayoutConstraint!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var messageBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        messageBackgroundView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
