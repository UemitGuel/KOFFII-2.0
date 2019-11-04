import UIKit
import Foundation
import CoreLocation

class MapFunctions {
    func returnMapOptionsAlert(cafeName: String, latitude: Double, longitude: Double) -> UIAlertController {
        let coordinates = CLLocationCoordinate2D(latitude: latitude,
                                                 longitude: longitude)
        let actionSheet = UIAlertController(title: "Open Location",
                                            message: "How you want to open?",
                                            preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let splitetStringName = cafeName.components(separatedBy: " ")
        guard let nameJoined = splitetStringName
            .joined(separator: "+")
            .addingPercentEncoding(withAllowedCharacters:
                .urlHostAllowed)
        else {
            fatalError("Hotelname not found")
        }
        let latitude = String(format: "%.6f", coordinates.latitude)
        let longitude = String(format: "%.6f", coordinates.longitude)

        // Google Maps
        let actionGoogleMaps = UIAlertAction(title: "Google Maps", style: .default) { _ in

            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                // ?q=Pizza&center=37.759748,-122.427135
                let url = URL(string: "comgooglemaps://?daddr=\(nameJoined)&center=\(latitude),\(longitude)")!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://")
            }
        }
        // Apple Maps
        let actionAppleMaps = UIAlertAction(title: "Apple Maps", style: .default) { _ in
            let coreUrl = "http://maps.apple.com/?"
            guard let url = URL(string: coreUrl +
                "q=\(nameJoined)&sll=" +
                latitude + "," + longitude +
                "&t=s")
            else {
                return print("error")
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        actionSheet.addAction(actionGoogleMaps)
        actionSheet.addAction(actionAppleMaps)
        actionSheet.addAction(actionCancel)
        return actionSheet
    }
}
