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
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        signInButton.layer.cornerRadius = 8
        
        automaticSingIn(onSuccess: {
            self.performSegue(withIdentifier: "fromLogtoHomeSegue", sender: nil)
            SVProgressHUD.dismiss()
        })
    }
    
    //MARK: -  Automatiches Einloggen
    func automaticSingIn(onSuccess: @escaping () -> Void) {
        if Auth.auth().currentUser != nil {
            SVProgressHUD.show()
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in
                    onSuccess()
                })
            }
        }
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
