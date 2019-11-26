import UIKit

class ComplainTableViewCell: UITableViewCell {
    @IBOutlet var complainLabel: UILabel!

    static let cellId = "complainCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
