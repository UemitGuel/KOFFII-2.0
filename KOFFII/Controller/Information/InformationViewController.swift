//
//  InformationViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 03.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase

class InformationViewController: UITableViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var db: Firestore!
    var docIDs = Array<String>()
    var information_brewing = Array<Information_Brewing>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        
        
        loadAllObjects(fromCollection: "Information_Brewing") {
            self.tableView.reloadData()
        }

    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    

    func loadAllObjects(fromCollection: String, completionHandler: @escaping () -> Void) {
        getAllDocumentIDs(fromCollection: fromCollection) { ids in
            self.docIDs = ids
            for id in ids {
                self.useDocumentIDToRetrieveObject(fromCollection: fromCollection, id: id, completionHandler: { object in
                    self.information_brewing.append(object)
                    completionHandler()
                })
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
    
    func useDocumentIDToRetrieveObject(fromCollection: String, id: String, completionHandler: @escaping (Information_Brewing) -> Void ) {
        let docRef = db.collection(fromCollection).document(id)
        
        docRef.getDocument { (document, error) in
            if let information = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Information_Brewing(dictionary: data)
                })
            }) {
                print("mmmmmmmmmm: \(information)")
                completionHandler(information)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information_brewing.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath) as! InformationTableViewCell
        cell.nameLabel?.text = information_brewing[indexPath.row].name
        cell.infoImageView?.image = UIImage(named: information_brewing[indexPath.row].imageName ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromInfoToDetailSegue" {
            let detailVC = segue.destination as! InformationDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.passedInformationBrewing = information_brewing[indexPath.row]

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromInfoToDetailSegue", sender: self)
    }
}
