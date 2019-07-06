//
//  InformationDetailViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 06.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit

class InformationDetailViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var passedInformationBrewing: Information_Brewing? {
        didSet{
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self

        guard let imageName = passedInformationBrewing?.imageName else { return }
        headerImageView.image = UIImage(named: imageName)
        
    }

}

extension InformationDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = passedInformationBrewing?.tips?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformationDetailTableViewCell", for: indexPath) as! InformationDetailTableViewCell
        guard let information = passedInformationBrewing else {
            return cell
        }
        guard let tips = information.tips else {
            return cell
        }
        cell.countLabel.text = String(indexPath.row)
        cell.longTextLabel.text = tips[indexPath.row]
        return cell
    }
    
    
}

extension InformationDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        
        headerView.quanLabel.text = passedInformationBrewing?.quan ?? ""
        headerView.tempLabel.text = passedInformationBrewing?.temp ?? ""
        headerView.timeLabel.text = passedInformationBrewing?.time ?? ""
        return headerView
    }
}
