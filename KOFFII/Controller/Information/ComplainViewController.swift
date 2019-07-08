//
//  ComplainViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 08.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit

class ComplainViewController: UIViewController {

    var passedComplainObject: Complain?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var complainLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        complainLabel.text = passedComplainObject?.name
    }

}

extension ComplainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedComplainObject?.improvements?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "complainCell", for: indexPath) as? ComplainTableViewCell
        cell?.complainLabel.text = passedComplainObject?.improvements?[indexPath.row]
        return cell!
    }
    
    
}


