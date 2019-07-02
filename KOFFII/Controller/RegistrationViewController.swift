//
//  RegistrationViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 27.06.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import RealmSwift

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func createButtonTapped(_ sender: UIButton) {
        
    SVProgressHUD.show()
        
    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
        if error != nil {
            print(error!)
        } else {
            print("Success")
        }
        do {
            try self.realm.write {
                let newUser = User()
                newUser.name = self.nameTextField.text
                newUser.email = self.emailTextField.text
                self.realm.add(newUser)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        SVProgressHUD.dismiss()
            
        self.performSegue(withIdentifier: "fromRegtoHomeSegue", sender: self)
            
        }
        
    }
}
