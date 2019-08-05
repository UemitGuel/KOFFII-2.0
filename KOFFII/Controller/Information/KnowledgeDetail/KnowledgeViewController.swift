//
//  KnowledgeViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 09.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit

class KnowledgeDetailViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var passedInformationKnowledge: Information?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupHeaderView()
    }
    
    // MARK: - Setup ViewController/Header
    func setupViewController() {
        self.tabBarController?.tabBar.isHidden = true
        title = passedInformationKnowledge?.name
    }
    
    func setupHeaderView() {
        guard let imageName = passedInformationKnowledge?.imageName else { return }
        headerImageView.image = UIImage(named: imageName)
    }

}

extension KnowledgeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = passedInformationKnowledge?.tips?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KnowledgeDetailTableViewCell", for: indexPath) as! KnowledgeDetailTableViewCell
        guard let information = passedInformationKnowledge else {
            return cell
        }
        guard let tips = information.tips else {
            return cell
        }
        cell.countLabel.text = String(indexPath.row + 1)
        cell.longTextLabel.text = tips[indexPath.row]
        return cell
    }
    
    
}

extension KnowledgeDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if passedInformationKnowledge?.quan != nil {
            return 100
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if passedInformationKnowledge?.quan != nil {
            let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
            
            headerView.quanLabel.text = passedInformationKnowledge?.quan ?? ""
            headerView.tempLabel.text = passedInformationKnowledge?.temp ?? ""
            headerView.timeLabel.text = passedInformationKnowledge?.time ?? ""
            return headerView
        } else {
            let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
            return view
        }
    }
}

