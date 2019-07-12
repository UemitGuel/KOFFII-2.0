//
//  CafeDetailViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 11.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

class CafeDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var toLocationButton: UIButton!
    
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
    
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sendButton: UIButton!
    
    var db: Firestore!
    
    var passedCityName: String?
    var passedCafeObject: Cafe?
    let regionRadius: CLLocationDistance = 1000

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupButtons()
        activateButtons()
        
        //Register MessagingCell
        tableView.register(UINib(nibName: "CustomMessageCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        
        // set map
        let location = CLLocation(latitude: passedCafeObject?.latitude ?? 0, longitude: passedCafeObject?.longitude ?? 0)
        centerMapOnLocation(location: location)

        // Adding TapGesture for Textfield
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }
    
    func setupButtons() {
        
        wifiButton.layer.cornerRadius = 8
        foodButton.layer.cornerRadius = 8
        veganButton.layer.cornerRadius = 8
        cakeButton.layer.cornerRadius = 8
        plugButton.layer.cornerRadius = 8
        
    }
    
    func activateButtons() {
        if passedCafeObject?.features!["wifi"] == true {
            wifiButton.customBGColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
            wifiButton.borderWidth = 2
            wifiLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["food"] == true {
            foodButton.customBGColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
            foodButton.borderWidth = 2
            foodLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["vegan"] == true {
            veganButton.customBGColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
            veganButton.borderWidth = 2
            veganLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["cake"] == true {
            cakeButton.customBGColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
            cakeButton.borderWidth = 2
            cakeLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["plugin"] == true {
            plugButton.customBGColor = UIColor(red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
            plugButton.borderWidth = 2
            plugLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func toLocationButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Choose your Map App", preferredStyle: .actionSheet)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Google Maps
        let actionGoogleMaps = UIAlertAction(title: "Google Maps", style: .default) { UIAlertAction in
            
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps-x-callback://")!)) {
                
                UIApplication.shared.open((URL(string: self.passedCafeObject?.locationURL ?? "")!) , options: [:] , completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://");
            }
        }
        
        //Apple Maps
        let actionAppleMaps = UIAlertAction(title: "Apple Maps", style: .default) { UIAlertAction in
            let longitude = String(format: "%.6f", self.passedCafeObject?.longitude ?? 0)
            let latitude = String(format: "%.6f", self.passedCafeObject?.latitude ?? 0)
            let splitetStringName = self.passedCafeObject!.name.components(separatedBy: " ")
            let cafeName = splitetStringName.joined(separator: "+")
            print(cafeName)
            guard let url = URL(string: "http://maps.apple.com/?q=\(cafeName)&sll=" + longitude + "," + latitude + "&t=s") else { return print("errror") }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
        
        alert.addAction(actionGoogleMaps)
        alert.addAction(actionAppleMaps)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let currentUserName = String()
//        db.collection("User").document(Auth.auth().currentUser!.uid).get()
        
        
        
        
        let ref = db.collection("City").document(passedCityName!).collection("Cafes")
        
        
        
        ref.document(passedCafeObject!.name).setData([
            "author": Auth.auth().currentUser?.uid,
            "state": "CA",
            "country": "USA"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
}

extension CafeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        let messages = ["Message 1","mddmemdemidmeimdiemdiemdimeidmeimdiemmdemdimeidmemdei", "sdksdmk"]
        cell.commentLabel?.text = messages[indexPath.row]
        return cell
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120.0
        
        
    }
    
    
}

extension CafeDetailViewController: UITableViewDelegate {
    
}

extension CafeDetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 1.0) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
            let scrollPoint = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height)
            self.tableView.setContentOffset(scrollPoint, animated: false)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
            self.tableView.setContentOffset(.zero, animated: false)
        }
    }
}
