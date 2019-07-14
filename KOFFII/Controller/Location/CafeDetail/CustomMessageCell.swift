//
//  CustomMessageCell.swift
//  KOFFII
//
//  Created by Ümit Gül on 12.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet weak var rightSideConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftSideContraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var messageBackgroundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBackgroundView.layer.cornerRadius = 8
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
