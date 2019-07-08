//
//  Information_Brewing.swift
//  KOFFII
//
//  Created by Ümit Gül on 04.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation

struct Information {
    let name: String
    let imageName: String?
    let quan: String?
    let temp: String?
    let time: String?
    let tips: Array<String>?
    let complainCatgory: String?
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        
        self.imageName = dictionary["imageName"] as? String
        self.quan = dictionary["quan"] as? String
        self.temp = dictionary["temp"] as? String
        self.time = dictionary["time"] as? String
        self.tips = dictionary["tips"] as? Array<String>
        self.complainCatgory = dictionary["complainCategory"] as? String
    }
}
