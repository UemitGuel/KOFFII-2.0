//
//  Cafe.swift
//  KOFFII
import Foundation

struct Cafe {
    let name: String
    let latitude: Double?
    let longitude: Double?
    let locationURL: String?
    let features: [String: Bool]?
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        
        self.latitude = dictionary["latitude"] as? Double
        self.longitude = dictionary["longitude"] as? Double
        self.locationURL = dictionary["locationURL"] as? String
        self.features = dictionary["features"] as? [String: Bool]
    }
}
