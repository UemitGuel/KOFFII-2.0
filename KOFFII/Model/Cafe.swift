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

        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        locationURL = dictionary["locationURL"] as? String
        features = dictionary["features"] as? [String: Bool]
    }
}
