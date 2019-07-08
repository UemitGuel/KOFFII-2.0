//
//  Complain.swift
//  KOFFII
//
//  Created by Ümit Gül on 08.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation


struct Complain{
    let name: String
    let improvements: Array<String>?
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        
        self.improvements = dictionary["improvements"] as? Array<String>
    }
}
