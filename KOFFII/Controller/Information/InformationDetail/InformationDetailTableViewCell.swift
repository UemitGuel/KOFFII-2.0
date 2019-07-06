//
//  InformationDetailTableViewCell.swift
//  KOFFII
//
//  Created by Ümit Gül on 06.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit

class InformationDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var longTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
