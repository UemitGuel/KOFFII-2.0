import UIKit

class City_CafeTableViewCell: UITableViewCell {

    @IBOutlet weak var cafeNameLabel: UILabel!
    
    @IBOutlet weak var cafeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cafeImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
