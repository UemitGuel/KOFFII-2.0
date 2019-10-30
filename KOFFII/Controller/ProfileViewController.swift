//
//  ProfileViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 14.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SVProgressHUD

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    var db: Firestore!
    let myGroupBarcelona = DispatchGroup()
    let myGroupCologne = DispatchGroup()
    let myGroupSecond = DispatchGroup()
    let myGroupThird = DispatchGroup()
    var sections_cityNames = ["Barcelona","Cologne"]
    
    var cafesBarcelona = Array<Cafe>()
    var cafesCologne = Array<Cafe>()
    var items: [Array<Cafe>] = []
    
    var currentUserFavCafesNames = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupViewController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cafesBarcelona.removeAll()
        cafesCologne.removeAll()
        items.removeAll()
        getAllCafeNamesFromUserCollection { array in
            self.currentUserFavCafesNames = array
            print(self.currentUserFavCafesNames)
            self.downloadAllFavCafesBarcelona {
                print("kmdkmkdmwdwkdmkwdmkwd\(self.items)")
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func setupViewController() {
        nameLabel.text = "Name: \(Auth.auth().currentUser?.displayName ?? "")"
        emailLabel.text = "Email: \(Auth.auth().currentUser?.email ?? "")"
        
        // eliminate 1pt line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        deleteAccountButton.layer.cornerRadius = 8

    }
    
    func getAllCafeNamesFromUserCollection(completionHandler: @escaping (Array<String>) -> Void) {
                let ref = db.collection("User").document(Auth.auth().currentUser!.uid)
        
                ref.getDocument { (document, error) in
                    if let currentUser = document.flatMap({
                        $0.data().flatMap({ (data) in
                            return User(dictionary: data)
                        })
                    }) {
                        print("Current User: \(currentUser)")
                        self.currentUserFavCafesNames = currentUser.favCafes ?? [""]
                        completionHandler(self.currentUserFavCafesNames)
                    } else {
                        print("Document does not exist")
                    }
                }
        }
    
    func downloadAllFavCafesBarcelona(completionHandler: @escaping () -> Void) {
        for cafeName in currentUserFavCafesNames {
            //Barcelona
            self.myGroupBarcelona.enter()
            self.db.collection("City").document("Barcelona").collection("Cafes").document(cafeName)
                .getDocument { (document, error) in
                    if let cafe = document.flatMap({
                        $0.data().flatMap({ (data) in
                            return Cafe(dictionary: data)
                        })
                    }) {
                        print("Cafe: \(cafe)")
                        self.cafesBarcelona.append(cafe)
                        self.myGroupBarcelona.leave()
                    } else {
                        print("Document does not exist")
                        self.myGroupBarcelona.leave()
                    }
            }
            //Cologne
            self.myGroupBarcelona.enter()
            self.db.collection("City").document("Cologne").collection("Cafes").document(cafeName)
                .getDocument { (document, error) in
                    if let cafe = document.flatMap({
                        $0.data().flatMap({ (data) in
                            return Cafe(dictionary: data)
                        })
                    }) {
                        print("Cafe: \(cafe)")
                        self.cafesCologne.append(cafe)
                        self.myGroupBarcelona.leave()
                    } else {
                        print("Document does not exist")
                        self.myGroupBarcelona.leave()
                    }
            }
        }
        self.myGroupBarcelona.notify(queue: .main) {
            print("Finished all requests /1/2.")
            self.cafesBarcelona = self.cafesBarcelona.sorted(by: { $0.name < $1.name})
            self.cafesCologne = self.cafesCologne.sorted(by: { $0.name < $1.name})
            self.items.append(self.cafesBarcelona)
            self.items.append(self.cafesCologne)
            completionHandler()
        }
    }
    
    @IBAction func deleteAccountButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "This will delete your profile and all your messages", preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionDelete = UIAlertAction(title: "Delete", style: .default) { UIAlertAction in
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

            //Delete User Info insde Database
            self.db.collection("User").document(Auth.auth().currentUser!.uid).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }

            // Delete User Information
            
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                print("delete account trigger")
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    // Account deleted.
                }
            }

            
        }
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            print("items full")
            return items[section].count
        } else {
            print("items empty")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fav_Cafes", for: indexPath) as! City_CafeTableViewCell
        cell.selectionStyle = .none

        cell.cafeNameLabel.text = items[indexPath.section][indexPath.row].name
        let url = URL(string: items[indexPath.section][indexPath.row].imageName!)
        cell.cafeImageView!.sd_setImage(with: url) { (_,_, _, _) in
        }
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections_cityNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections_cityNames[section]
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
    
    
    // Segue to Cafe Detail View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromProfiletoDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromProfiletoDetailSegue" {
            let cityDetailVC = segue.destination as! CafeDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                cityDetailVC.passedCafeObject = items[indexPath.section][indexPath.row]
                cityDetailVC.passedCityName = sections_cityNames[indexPath.section]
            }
        }
    }
}
    
