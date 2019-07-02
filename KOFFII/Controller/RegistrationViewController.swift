//
//  RegistrationViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 27.06.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
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
            
        SVProgressHUD.dismiss()
            
        self.performSegue(withIdentifier: "fromRegtoHomeSegue", sender: self)
            
        }
        
    }
}
