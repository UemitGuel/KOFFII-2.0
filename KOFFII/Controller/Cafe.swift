//
//  Cafe.swift
//  KOFFII
//
//  Created by Ümit Gül on 02.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation
import RealmSwift

enum City: String {
    case Barcelona
    case Cologne
}

class Cafe: Object {
    
    //MARK: Name
    @objc dynamic var name: String = ""
    
    // MARK: City
    var city = City.Barcelona.rawValue
    var cityEnum: City {
        get {
            return City(rawValue: city)!
        }
        set {
            city = newValue.rawValue
        }
    }
        
    // MARK: Features
    @objc dynamic var wifi: Bool = false
    @objc dynamic var food: Bool = false
    @objc dynamic var vegan: Bool = false
    @objc dynamic var cake : Bool = false
    @objc dynamic var plugin: Bool = false
    
    //MARK: Location
    @objc dynamic let latitude: Double = 0.0
    @objc dynamic let longitude: Double = 0.0
    @objc dynamic let locationURL: String = ""
    
    //MARK: Images
    @objc dynamic let imageURL: String = ""
    
    //MARK: Favorite Cafes
    @objc dynamic var favorite: Bool = false
    
}

