//
//  CafeTableViewCell.swift
//  KOFFII
//
//  Created by Ümit Gül on 06.04.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell {
    
    static func getModifiedCell(item: Cafe, userLocationEnabled: Bool) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "DefaultCell")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textLabel?.text = item.name
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        if userLocationEnabled {
            cell.detailTextLabel?.text = MapHelper.getDistanceAsStringRounded(latitude: item.latitude, longitude: item.longitude)
        } else {
            cell.detailTextLabel?.text = item.neighborhood
        }
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        cell.imageView?.image = UIImage(asset: Asset.coffeeIcon)
        return cell
    }
}
