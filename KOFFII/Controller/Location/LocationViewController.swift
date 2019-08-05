//
//  LocationViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 09.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SVProgressHUD
import MessageUI

class LocationViewController: UIViewController {

    @IBOutlet weak var recommendButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    var db: Firestore!
    var cityNames = Array<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        loadCityNames() { tempCityNames in
            self.cityNames = tempCityNames
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
        
        recommendButton.layer.cornerRadius = 8

    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    //MARK: - Handling the appearence and disappearnce of the Navigation and Tabbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Loading all CityName. Just querriny the names, so we don´t use to much data at this point.
    func loadCityNames(completionHandler: @escaping (Array<String>) -> Void) {
        SVProgressHUD.show()
        var tempCityNames = Array<String>()
        db.collection("City").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    tempCityNames.append(document.documentID)
                }
                completionHandler(tempCityNames)
            }
        }
    }
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            //Show alert informing the user
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["uemitgul@gmail.com"])
        composer.setSubject("You forgot this amazing coffee place!")
        composer.setMessageBody("Hi Ümit,\nCool app, but you should add XY Cafe in YZ to the list. They have...(wifi, food, vegan options, cake, plug?)\n\nAnd for the app, I would recommend you to ...", isHTML: false)
        
        present(composer, animated: true)
    }
    
    @IBAction func recommendButtonTapped(_ sender: UIButton) {
        showMailComposer()
    }
    

}

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        cell.selectionStyle = .none
        
        cell.cityLabel.text = cityNames[indexPath.row]
        //MARK: name and ImageName have to be the same so this works
        cell.locationImageView.image = UIImage(named: cityNames[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    
}

extension LocationViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Location"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromLoctoCitySegue" {
            let cityVC = segue.destination as! CityViewController
                
            if let indexPath = tableView.indexPathForSelectedRow {
                cityVC.passedCityName = cityNames[indexPath.row]
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "fromLoctoCitySegue", sender: self)
    }
    
}

extension LocationViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            //Show error alert
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed to send")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        @unknown default:
            fatalError()
        }
        
        controller.dismiss(animated: true)
    }
}
