//
//  RegistrationViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 27.06.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SVProgressHUD

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirebase()

    }
    
    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    

    @IBAction func createButtonTapped(_ sender: UIButton) {
        
    SVProgressHUD.show()
        
    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
        if error != nil {
            print(error!)
        } else {
            print("Success")
            self.db.collection("User").document(Auth.auth().currentUser!.uid).setData([
                "name": self.nameTextField.text!,
                "email": self.emailTextField.text!,
                "favCafes": []
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = self.nameTextField.text
            changeRequest?.commitChanges { (error) in
                print(error)
            }
            
            SVProgressHUD.dismiss()
            
            self.performSegue(withIdentifier: "fromRegtoHomeSegue", sender: self)
        }
    }
}
}
