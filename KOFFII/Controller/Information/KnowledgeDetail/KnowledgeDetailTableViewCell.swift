import UIKit

class KnowledgeDetailTableViewCell: UITableViewCell {
    @IBOutlet var longTextLabel: UILabel!
    @IBOutlet var countLabel: UILabel!

    static let cellId = "KnowledgeDetailTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
