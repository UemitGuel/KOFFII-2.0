//
//  UserModel.swift
//  KOFFII
//
//  Created by Ümit Gül on 02.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    
}
