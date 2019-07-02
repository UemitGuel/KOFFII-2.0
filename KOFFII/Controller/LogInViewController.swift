//
//  LogInViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 02.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Login Success!")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "fromLogtoHomeSegue", sender: self)
                
            }
        }
        
    }
    


}
