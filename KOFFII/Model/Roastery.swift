//
//  Roastery.swift
//  KOFFII
//
//  Created by Ümit Gül on 30.10.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation

struct Roastery {
    let name: String
    let latitude: Double?
    let longitude: Double?
    let locationURL: String?
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.locationURL = dictionary["locationURL"] as? String
    }
}
