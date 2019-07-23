//
//  User.swift
//  KOFFII
//
//  Created by Ümit Gül on 04.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation

struct User {
//    let UserID: String?
    let name: String
    let email: String
    let favCafes: Array<String>?
    
    init?(dictionary: [String: Any]) {
        self.favCafes = dictionary["favCafes"] as? Array<String>
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
