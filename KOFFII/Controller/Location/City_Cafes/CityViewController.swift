//
//  CityViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 09.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SVProgressHUD

// Needed to compare requested Features, so what the users clicked, and the actual value inside the data
enum Features {
    case Wifi
    case Food
    case Vegan
    case Cake
    case Plug
}

class CityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var wifiButton: RoundButton!
    @IBOutlet weak var wifiLabel: UILabel!
    
    @IBOutlet weak var foodButton: RoundButton!
    @IBOutlet weak var foodLabel: UILabel!
    
    @IBOutlet weak var veganButton: RoundButton!
    @IBOutlet weak var veganLabel: UILabel!
    
    @IBOutlet weak var cakeButton: RoundButton!
    @IBOutlet weak var cakeLabel: UILabel!
    
    @IBOutlet weak var plugButton: RoundButton!
    @IBOutlet weak var plugLabel: UILabel!
    

    var db: Firestore!
    let myGroup = DispatchGroup()

    var cafeObjects = Array<Cafe>()
    var filteredCafeObjects = Array<Cafe>()
    var requestedFeatures : [Features] = []
    var passedCityName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupButtons()
        setupViewController()
        
        downloadAllCafeIDsForTheCity(city: passedCityName) { ids in
            for id in ids {
                self.myGroup.enter()
                self.useCafeIDToDownloadObject(id: id, city: self.passedCityName, completionHandler: { cafe in
                    self.cafeObjects.append(cafe)
                    self.myGroup.leave()
                })
            }
            self.myGroup.notify(queue: .main) {
                print("Finished all requests.")
                self.tableView.reloadData()
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
    
    func setupButtons() {
        
        wifiButton.layer.cornerRadius = 8
        foodButton.layer.cornerRadius = 8
        veganButton.layer.cornerRadius = 8
        cakeButton.layer.cornerRadius = 8
        plugButton.layer.cornerRadius = 8
        
    }
    
    func setupViewController() {
        // eliminate 1pt line
        self.tabBarController?.tabBar.isHidden = true
        title = passedCityName
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func downloadAllCafeIDsForTheCity(city: String, completionHandler: @escaping (Array<String>) -> Void) {
        var tempCafeNames = Array<String>()
        db.collection("City").document(city).collection("Cafes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    tempCafeNames.append(document.documentID)
                }
                completionHandler(tempCafeNames)
            }
        }
    }
    
    func useCafeIDToDownloadObject(id: String, city: String, completionHandler: @escaping (Cafe) -> Void) {
        let docRef = db.collection("City").document(city).collection("Cafes").document(id)
        
        docRef.getDocument { (document, error) in
            if let cafe = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Cafe(dictionary: data)
                })
            }) {
                completionHandler(cafe)
            } else {
                print("Document does not exist")
            }
        }
    }
    
    // Handling what happens when Feature Buttons get clicked
    @IBAction func wifiButtonTapped(_ sender: UIButton) {
        if !requestedFeatures.contains(.Wifi) {
            requestedFeatures.append(.Wifi)
            
            wifiButton.customBGColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            wifiButton.borderWidth = 2
            wifiLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
            
            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter({ return $0 != .Wifi})
            
            wifiButton.customBGColor = UIColor.white
            wifiButton.borderWidth = 1
            wifiLabel.font = UIFont(name: "Quicksand-Medium", size: 15)
            
            filtering()
            tableView.reloadData()
        }
    }
    
    @IBAction func foodButtonTapped(_ sender: UIButton) {
        if !requestedFeatures.contains(.Food) {
            requestedFeatures.append(.Food)
            
            foodButton.customBGColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            foodButton.borderWidth = 2
            foodLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
            
            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter({ return $0 != .Food})
            
            
            foodButton.customBGColor = UIColor.white
            foodButton.borderWidth = 1
            foodLabel.font = UIFont(name: "Quicksand-Medium", size: 15)
            
            filtering()
            tableView.reloadData()
        }
    }
    
    @IBAction func veganButtonTapped(_ sender: UIButton) {
        if !requestedFeatures.contains(.Vegan) {
            requestedFeatures.append(.Vegan)
            
            veganButton.customBGColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            veganButton.borderWidth = 2
            veganLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
            
            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter({ return $0 != .Vegan})
            
            veganButton.customBGColor = UIColor.white
            veganButton.borderWidth = 1
            veganLabel.font = UIFont(name: "Quicksand-Medium", size: 15)
            
            filtering()
            tableView.reloadData()
        }
    }
    
    @IBAction func cakeButtonTapped(_ sender: UIButton) {
        if !requestedFeatures.contains(.Cake) {
            requestedFeatures.append(.Cake)
            
            cakeButton.customBGColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            cakeButton.borderWidth = 2
            cakeLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
            
            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter({ return $0 != .Cake})
            
            cakeButton.customBGColor = UIColor.white
            cakeButton.borderWidth = 1
            cakeLabel.font = UIFont(name: "Quicksand-Medium", size: 15)
            
            filtering()
            tableView.reloadData()
        }
    }
    
    @IBAction func plugButtonTapped(_ sender: UIButton) {
        if !requestedFeatures.contains(.Plug) {
            requestedFeatures.append(.Plug)
            
            plugButton.customBGColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1)
            plugButton.borderWidth = 2
            plugLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
            
            filtering()
            tableView.reloadData()
        } else {
            requestedFeatures = requestedFeatures.filter({ return $0 != .Plug})
            
            plugButton.customBGColor = UIColor.white
            plugButton.borderWidth = 1
            plugLabel.font = UIFont(name: "Quicksand-Medium", size: 15)
            
            filtering()
            tableView.reloadData()
        }
    }
    
    
    // Active Filtering, if feature buttons are clicked
    func isFiltering() -> Bool {
        return !requestedFeatures.isEmpty
    }
    
    func filtering() {
        filteredCafeObjects = cafeObjects
        if requestedFeatures.contains(.Wifi) {
            filteredCafeObjects = filteredCafeObjects.filter({return $0.features!["wifi"] == true})
        }
        if requestedFeatures.contains(.Food) {
            filteredCafeObjects = filteredCafeObjects.filter({return $0.features!["food"] == true})
        }
        if requestedFeatures.contains(.Vegan) {
            filteredCafeObjects = filteredCafeObjects.filter({return $0.features!["vegan"] == true})
        }
        if requestedFeatures.contains(.Cake) {
            filteredCafeObjects = filteredCafeObjects.filter({return $0.features!["cake"] == true})
        }
        if requestedFeatures.contains(.Plug) {
            filteredCafeObjects = filteredCafeObjects.filter({return $0.features!["plugin"] == true})
        }
    }
    
    
}
    


extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCafeObjects.count
        } else {
            return cafeObjects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City_CafeTableViewCell", for: indexPath) as! City_CafeTableViewCell
        cell.selectionStyle = .none
        
        if isFiltering() {
            let url = URL(string: filteredCafeObjects[indexPath.row].imageName!)
            cell.cafeImageView.sd_setImage(with: url) { (_, _, _, _) in
            }
            cell.cafeNameLabel.text = filteredCafeObjects[indexPath.row].name
            
        } else {
            let url = URL(string: cafeObjects[indexPath.row].imageName!)
            cell.cafeImageView.sd_setImage(with: url) { (_, _, _, _) in
            }
            cell.cafeNameLabel.text = cafeObjects[indexPath.row].name
        }
        
        // Creates the fav button
        let button   = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: 20, y: 20, width: 30, height: 30)
        
        // This is to check if the star button should be fill or unfilled
        checkIfDocumentForThisUserExists { bool in
            if bool == true {
                self.db.collection("FavCafes").document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
                    if let favCafe = document.flatMap({
                        $0.data().flatMap({ (data) in
                            return FavCafes(dictionary: data)
                        })
                    }) {
                        print("FavCafe: \(favCafe)")
                        for cafe in favCafe.favCafes! {
                            if cafe == self.cafeObjects[indexPath.row].name {
                                button.setBackgroundImage(UIImage(named:"star_filled"), for: .normal)
                            } else {
                                button.setBackgroundImage(UIImage(named:"star_unfilled"), for: .normal)
                            }
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
            } else if bool == false {
                button.setBackgroundImage(UIImage(named:"star_unfilled"), for: .normal)
            }
        }
        
        button.addTarget(self, action: #selector(handleButtonTapped(sender:)), for:.touchUpInside)
        button.tag = indexPath.row
        cell.accessoryView = button

        return cell
    }
    
    // Checking if the document already exists. Important for updateFavCafesCollectionForCurrentUser()
    func checkIfDocumentForThisUserExists(completionHandler: @escaping (Bool) -> Void) {
        var currentUserAlreadyHasDocument = false
        let currentUser = Auth.auth().currentUser?.uid
        let newDocRef = db.collection("FavCafes").document(currentUser!)
        newDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                currentUserAlreadyHasDocument = true
                completionHandler(currentUserAlreadyHasDocument)

            } else {
                currentUserAlreadyHasDocument = false
                completionHandler(currentUserAlreadyHasDocument)
            }
        }
    }
    
    func updateFavCafesCollectionForCurrentUser(sender: UIButton, newFavStatus: Bool) {
        
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
        let currentUser = Auth.auth().currentUser?.uid
        let newDocRef = db.collection("FavCafes").document(currentUser!)
        var userAlreadyHasDocument : Bool?
        
        checkIfDocumentForThisUserExists { bool in
            userAlreadyHasDocument = bool
            if bool == true && newFavStatus == true {
                self.db.collection("FavCafes").document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
                    if let favCafe = document.flatMap({
                        $0.data().flatMap({ (data) in
                            return FavCafes(dictionary: data)
                        })
                    }) {
                        print("FavCafe: \(favCafe)")
                        for cafe in favCafe.favCafes! {
                            if cafe == self.cafeObjects[selectedIndex.row].name {
                                newDocRef.updateData([
                                    "favCafes": FieldValue.arrayUnion([self.cafeObjects[selectedIndex.row].name])
                                    ])
                            } else if newFavStatus == false {
                                newDocRef.updateData([
                                    "favCafes": FieldValue.arrayRemove([self.cafeObjects[selectedIndex.row].name])
                                    ])
                            }
                            }
                    }
                }
                } else if bool == false && newFavStatus == true {
                    newDocRef.setData([
                        "favCafes": [self.cafeObjects[selectedIndex.row].name]
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
//            if newFavStatus == true && userAlreadyHasDocument == false {
//                
//                newDocRef.setData([
//                    "favCafes": [self.cafeObjects[selectedIndex.row].name]
//                ]) { err in
//                    if let err = err {
//                        print("Error writing document: \(err)")
//                    } else {
//                        print("Document successfully written!")
//                    }
//                }
//            } else if newFavStatus == true && userAlreadyHasDocument == true {
//                
//                
////                newDocRef.updateData([
//                    "favCafes": FieldValue.arrayUnion([self.cafeObjects[selectedIndex.row].name])
//                    ])
//            } else if newFavStatus == false {
//                newDocRef.updateData([
//                    "favCafes": FieldValue.arrayRemove([self.cafeObjects[selectedIndex.row].name])
//                    ])
            }
        }
    }
    
    // Handels what happens when the Fav Button is clicked.
    @objc func handleButtonTapped(sender: UIButton) {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        let selectedIndex = IndexPath(row: sender.tag, section: 0)
        tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)

        print(sender.tag)
        
        if sender.tag == 0 {
            updateFavCafesCollectionForCurrentUser(sender: sender, newFavStatus: true)
            sender.tag = 1
        } else if sender.tag == 1{
            updateFavCafesCollectionForCurrentUser(sender: sender, newFavStatus: false)
            sender.tag = 0
        }
        print(sender.tag)

        self.tableView.reloadData()
        SVProgressHUD.dismiss()
        self.view.isUserInteractionEnabled = true
        }
}

extension CityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromCitytoDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromCitytoDetailSegue" {
            let cityDetailVC = segue.destination as! CafeDetailViewController
                
            if let indexPath = tableView.indexPathForSelectedRow {
                if isFiltering() {
                    cityDetailVC.passedCafeObject = filteredCafeObjects[indexPath.row]
                    cityDetailVC.passedCityName = passedCityName
                } else {
                    cityDetailVC.passedCafeObject = cafeObjects[indexPath.row]
                    cityDetailVC.passedCityName = passedCityName

                }
            }
        }
    }
}
