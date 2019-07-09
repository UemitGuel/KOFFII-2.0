//
//  InformationDetailViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 06.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase

class BrewingDetailViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var db: Firestore!
    var downloadedComplainObject : Complain?
    let myGroup = DispatchGroup()
    let myGrouptwo = DispatchGroup()

    var passedInformationBrewing: Information?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupViewController()
        setupTableViewHeader()
        setupComplainButton()
    }
    
    //MARK: - Setup Firebase/ViewController/TableViewHeader
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func setupViewController() {
        self.tabBarController?.tabBar.isHidden = true
        title = passedInformationBrewing?.name
    }
    
    func setupTableViewHeader() {
        guard let imageName = passedInformationBrewing?.imageName else { return }
        headerImageView.image = UIImage(named: imageName)
    }
    
    //MARK: - Setup Complain Buttons. After, downloading the right Complain-Model Object by checking which button is tapped(via tag) and which complainCategory("Coffee" or "Espresso") is choosen, and then the right document from Firestore is downloaded ( Collecton: Complain )
    func setupComplainButton() {
        if let passedCategory = passedInformationBrewing?.complainCatgory {
            if passedCategory == "Coffee" {
                db.collection("Complain").whereField("coffee", arrayContains: true)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            var docIDs = Array<String>()
                            self.myGroup.enter()
                            for document in querySnapshot!.documents {
                                self.myGroup.enter()
                                docIDs.append(document.documentID)
                            }
                        }
                }
                self.rightButton.setTitle("coffee too sour?", for: .normal)
                self.leftButton.setTitle("coffee too bitter?", for: .normal)
            } else {
                self.rightButton.setTitle("espresso too sour?", for: .normal)
                self.leftButton.setTitle("espresso to bitter?", for: .normal)
            }
        } else {
            self.rightButton.setTitle("", for: .normal)
            self.leftButton.setTitle("", for: .normal)
        }
    }
    
    
    @IBAction func complainButtonTapped(_ sender: UIButton) {
    
        guard let complainCategory = passedInformationBrewing?.complainCatgory else { return }
        downloadComplainObject(senderTag: sender.tag, complainCategory: complainCategory) { complain in
            self.downloadedComplainObject = complain
            self.performSegue(withIdentifier: "fromDetailToComplainSegue", sender: self)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromDetailToComplainSegue" {
            let complainVC = segue.destination as! ComplainViewController
            complainVC.passedComplainObject = downloadedComplainObject
            }
        }
    
    func downloadComplainObject(senderTag: Int, complainCategory: String, completionHandler: @escaping (Complain) -> Void) {
        var tempComplainObject : Complain?
        let collectionRef = db.collection("Complain")
        if complainCategory == "Coffee" && senderTag == 0 {
            
            collectionRef.document("coffee too bitter?").getDocument { (document, error) in
                if let complain = document.flatMap({
                    $0.data().flatMap({ (data) in
                        return Complain(dictionary: data)
                    })
                }) {
                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)

                } else {
                    print("Document does not exist")
                }
            }
        } else if complainCategory == "Coffee" && senderTag == 1 {
            collectionRef.document("coffee too sour?").getDocument { (document, error) in
                if let complain = document.flatMap({
                    $0.data().flatMap({ (data) in
                        return Complain(dictionary: data)
                    })
                }) {
                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)
                    
                } else {
                    print("Document does not exist")
                }
            }
        } else if complainCategory == "Espresso" && senderTag == 0 {
            collectionRef.document("espresso too bitter?").getDocument { (document, error) in
                if let complain = document.flatMap({
                    $0.data().flatMap({ (data) in
                        return Complain(dictionary: data)
                    })
                }) {
                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)
                    
                } else {
                    print("Document does not exist")
                }
            }
        } else if complainCategory == "Espresso" && senderTag == 1 {
            collectionRef.document("espresso too sour?").getDocument { (document, error) in
                if let complain = document.flatMap({
                    $0.data().flatMap({ (data) in
                        return Complain(dictionary: data)
                    })
                }) {
                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)
                    
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}

extension BrewingDetailViewController: UITableViewDataSource {
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

extension BrewingDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if passedInformationBrewing?.quan != nil {
            return 100
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if passedInformationBrewing?.quan != nil {
            let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
            
            headerView.quanLabel.text = passedInformationBrewing?.quan ?? ""
            headerView.tempLabel.text = passedInformationBrewing?.temp ?? ""
            headerView.timeLabel.text = passedInformationBrewing?.time ?? ""
            return headerView
        } else {
            let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
            return view
    }
    }
}
