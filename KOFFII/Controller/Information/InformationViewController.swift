//
//  InformationViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 03.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class InformationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var db: Firestore!
    var docIDs = Array<String>()
    var informationBrew = Array<Information>()
    var informationKnow = Array<Information>()
    let sections = ["Brewing","Knowledge"]
    var items = [Array<Information>]()
    
    let myGroup = DispatchGroup()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupNavBar()
        
        
        //MARK: Loading Content from FireStore
        SVProgressHUD.show()
        loadAllObjects(fromCollection: "Information_Brewing") { array in
            self.items.append(array)
            self.loadAllObjects(fromCollection: "Information_Knowledge") { array in
                self.items.append(array)
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
        

    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func setupNavBar() {
        self.navigationController?.isNavigationBarHidden = false


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    func loadAllObjects(fromCollection: String, completionHandler: @escaping (Array<Information>) -> Void) {
        var tempInformation = Array<Information>()
        getAllDocumentIDs(fromCollection: fromCollection) { ids in
            self.docIDs = ids
            for id in ids {
                self.myGroup.enter()
                self.useDocumentIDToRetrieveObject(fromCollection: fromCollection, id: id, completionHandler: { object in
                    tempInformation.append(object)
                    self.myGroup.leave()
                })
            }
            self.myGroup.notify(queue: .main) {
                print("Finished all requests.")
                completionHandler(tempInformation)
            }
            
        }
    }
    
    func getAllDocumentIDs(fromCollection: String, completionHandler: @escaping (Array<String>) -> Void) {
        var tempDocIDs = Array<String>()
        let docRef = db.collection(fromCollection)
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    tempDocIDs.append(document.documentID)
                }
                completionHandler(tempDocIDs)
            }
        }
    }
    
    func useDocumentIDToRetrieveObject(fromCollection: String, id: String, completionHandler: @escaping (Information) -> Void ) {
        let docRef = db.collection(fromCollection).document(id)
        
        docRef.getDocument { (document, error) in
            if let information = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Information(dictionary: data)
                })
            }) {
                print("mmmmmmmmmm: \(information)")
                completionHandler(information)
            } else {
                print("Document does not exist")
            }
        }
    }
}

extension InformationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath) as! InformationTableViewCell
        cell.nameLabel?.text = items[indexPath.section][indexPath.row].name
        cell.infoImageView?.image = UIImage(named: items[indexPath.section][indexPath.row].imageName ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromInfoToDetailSegue" {
            let detailVC = segue.destination as! InformationDetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.passedInformationBrewing = items[indexPath.section][indexPath.row]

            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromInfoToDetailSegue", sender: self)
    }


//MARK: Sections for TableView

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            print("items full")
            return items[section].count
        } else {
            print("items empty")
            return 0

        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        
        let header = view as! UITableViewHeaderFooterView
        guard let customFont = UIFont(name: "Staatliches-Regular", size: 40) else {
            fatalError("""
        Failed to load the "CustomFont-Light" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        header.textLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
        header.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
