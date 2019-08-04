//
//  ViewController.swift
//  KOFFII
//
//  Created by Ümit Gül on 27.06.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import UIKit
import Firebase

class WelcomeView: UIViewController {

    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)

       
        createButton.layer.cornerRadius = 8
        signInButton.layer.cornerRadius = 8
        
    }

    //MARK: - Handling the appearence and disappearnce of the Navigation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

