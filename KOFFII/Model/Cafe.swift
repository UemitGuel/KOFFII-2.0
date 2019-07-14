//
//  Cafe.swift
//  KOFFII
//
//  Created by Ümit Gül on 10.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation

struct Cafe {
    let name: String
    let imageName: String?
    let latitude: Double?
    let longitude: Double?
    let locationURL: String?
    let features: [String: Bool]?
//    let fav: Bool?
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        
        self.imageName = dictionary["imageName"] as? String
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.locationURL = dictionary["locationURL"] as? String
        self.features = dictionary["features"] as? [String: Bool]
//        self.fav = dictionary["fav"] as? Bool
    }
}
