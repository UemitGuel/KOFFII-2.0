//
//  FavCafes.swift
//  KOFFII
//
//  Created by Ümit Gül on 14.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation

struct FavCafes{
    let favCafes: Array<String>?
    
    init?(dictionary: [String: Any]) {
        self.favCafes = dictionary["favCafes"] as? Array<String>
    }
}
