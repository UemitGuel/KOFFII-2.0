//
//  Message.swift
//  KOFFII
//
//  Created by Ümit Gül on 12.07.19.
//  Copyright © 2019 Ümit Gül. All rights reserved.
//

import Foundation
import Firebase

struct Message{
    let author: String
    let date: String?
    let message: String?
    let timeStamp: Timestamp?
    
    init?(dictionary: [String: Any]) {
        guard let author = dictionary["author"] as? String else { return nil }
        self.author = author
        
        self.date = dictionary["date"] as? String
        self.message = dictionary["message"] as? String
        self.timeStamp = dictionary["created"] as? Timestamp
    }
}
