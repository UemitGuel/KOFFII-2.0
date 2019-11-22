import UIKit

class HeaderView: UITableViewCell {
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var brewingTime: UILabel!
    
    
    @IBOutlet var quanLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var seperator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        seperator.layer.cornerRadius = 8
        quantity.text = L10n.quantity
        temperature.text = L10n.temperature
        brewingTime.text = L10n.brewingTime
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
