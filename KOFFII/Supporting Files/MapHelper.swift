import UIKit
import Foundation
import CoreLocation
import MapKit

class MapHelper {
    static let regionRadius: CLLocationDistance = 1000
    static let locationManager = CLLocationManager()

    
    static func returnMapOptionsAlert(cafeName: String, latitude: Double, longitude: Double) -> UIAlertController {
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
    
    // Showing and handeling location
    static func centerMapOnLocation(map: MKMapView, location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    static func mapDistanceForDisplay(_ distance: CLLocationDistance) -> String {
        if distance < 100 { 
            return "100 m"
        } else if distance < 200 {
            return "200 m"
        } else if distance < 300 {
            return "300 m"
        } else if distance < 400 {
            return "400 m"
        } else if distance < 500 {
            return "500 m"
        } else if distance < 600 {
            return "600 m"
        } else if distance < 700 {
            return "700 m"
        } else if distance < 800 {
            return "800 m"
        } else if distance < 900 {
            return "900 m"
        } else if distance < 1000 {
            return "1 km"
        } else if distance < 1200 {
            return "1.2 km"
        } else if distance < 1500 {
            return "1.5 km"
        } else if distance < 2000 {
            return "2 km"
        } else if distance < 5000 {
            return "5km"
        } else if distance < 10000 {
            return "10km"
        } else {
            return "+10km"
        }
    }
    
    static func getDistanceAsStringRounded(latitude: Double, longitude: Double) -> String {
        let userLocation = MapHelper.getUserLocation()
        let cafeLocation = MKMapPoint(CLLocationCoordinate2DMake(latitude, longitude))
        let distance = userLocation.distance(to: cafeLocation)
        let distanceAsStringRounded = mapDistanceForDisplay(distance)
        return distanceAsStringRounded
    }
    
    static func getUserLocation() -> MKMapPoint {
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { fatalError() }
        return MKMapPoint(locValue)
    }
    
    static func getDistancefromUserToCafe(latitude: Double, longitude: Double) -> CLLocationDistance {
        let userLocation = MapHelper.getUserLocation()
        let distance = userLocation.distance(to: MKMapPoint(CLLocationCoordinate2DMake(latitude, longitude)))
        return distance
    }
}
