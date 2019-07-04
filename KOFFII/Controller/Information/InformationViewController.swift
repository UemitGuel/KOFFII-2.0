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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirebase()
        getMultipleDocumentsAndStoreTheirIDs(category: "Information_Brewing") { array in
            self.docIDs = array
        }
        
        print(docIDs)

    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    
    func getMultipleDocumentsAndStoreTheirIDs(category: String, completion: @escaping (Array<String>) -> Void) {
        var temporaryDocIDs = Array<String>()
        db.collection(category).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        temporaryDocIDs.append(document.documentID)
                        print("33333333333333333")
                        print(temporaryDocIDs)
                    }
                    completion(temporaryDocIDs)
                }
        }

    }

    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath)
        return cell
    }
    
}
