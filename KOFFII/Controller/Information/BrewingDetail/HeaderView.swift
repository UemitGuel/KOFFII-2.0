import UIKit

class HeaderView: UITableViewCell {

    @IBOutlet weak var quanLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seperator: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        seperator.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
