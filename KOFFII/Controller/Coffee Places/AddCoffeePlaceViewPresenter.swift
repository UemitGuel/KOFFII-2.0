//
//  AddCoffeePlaceViewPresenter.swift
//  KOFFII
//
//  Created by Ümit Gül on 05.04.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import UIKit
import SwiftUI

class AddCoffeePlaceViewPresenter: UIViewController {

    @IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: AddCoffeePlaceView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
