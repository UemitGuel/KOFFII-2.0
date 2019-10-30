//
//  CityViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 09.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
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
    
    @IBOutlet weak var usernameOutlet: UIBarButtonItem!
    
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
        
        downloadCafes() { cafeArray in
            self.cafeObjects = cafeArray
            self.cafeObjects = self.cafeObjects.sorted(by: { $0.name < $1.name})
            self.filteredCafeObjects = self.filteredCafeObjects.sorted(by: { $0.name < $1.name})
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
    
    func setupButtons() {
        
        wifiButton.layer.cornerRadius = 8
        foodButton.layer.cornerRadius = 8
        veganButton.layer.cornerRadius = 8
        cakeButton.layer.cornerRadius = 8
        plugButton.layer.cornerRadius = 8
        
    }
    
    func setupViewController() {
        // eliminate 1pt line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        usernameOutlet.title = username
        
    }
    
    func downloadCafes(completionHandler: @escaping (Array<Cafe>) -> Void) {
        var cafeArray : Array<Cafe> = []
        db.collection("City")
            .document("Cologne")
            .collection("Cafes")
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let d = document.data()
                    guard let cafe = Cafe(dictionary: d) else { return }
                    print("add cafe \(cafe)")
                    cafeArray.append(cafe)
                }
                completionHandler(cafeArray)

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
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Change Username", message: "enter your new username", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        alert.addTextField { (textField) in
            textField.text = username
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text ?? "")")
            UserDefaults.standard.set(textField?.text, forKey: "username")
            let username = UserDefaults.standard.string(forKey: "username") ?? ""
            self.usernameOutlet.title = username
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addPlaceButtonTapped(_ sender: UIBarButtonItem) {
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
            cell.cafeNameLabel.text = filteredCafeObjects[indexPath.row].name
        } else {
            cell.cafeNameLabel.text = cafeObjects[indexPath.row].name
        }
        return cell
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
                } else {
                    cityDetailVC.passedCafeObject = cafeObjects[indexPath.row]

                }
            }
        }
    }
}
