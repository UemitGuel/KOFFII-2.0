import CoreLocation
import FirebaseFirestore
import MapKit
import SVProgressHUD
import UIKit

class CafeDetailViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var map: MKMapView!
    @IBOutlet var toLocationButton: UIButton!

    @IBOutlet var wifiButton: RoundButton!
    @IBOutlet var wifiLabel: UILabel!

    @IBOutlet var foodButton: RoundButton!
    @IBOutlet var foodLabel: UILabel!

    @IBOutlet var veganButton: RoundButton!
    @IBOutlet var veganLabel: UILabel!

    @IBOutlet var cakeButton: RoundButton!
    @IBOutlet var cakeLabel: UILabel!

    @IBOutlet var plugButton: RoundButton!
    @IBOutlet var plugLabel: UILabel!

    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var heightConstraint: NSLayoutConstraint!

    @IBOutlet var sendButton: UIButton!

    var db: Firestore!
    let myGroup = DispatchGroup()

    var cityName = "Cologne"
    var passedCafeObject: Cafe?
    let regionRadius: CLLocationDistance = 1000
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFirebase()
        activateButtons()

        // set map
        let location = CLLocation(latitude: passedCafeObject?.latitude ?? 0,
                                  longitude: passedCafeObject?.longitude ?? 0)
        centerMapOnLocation(location: location)

        title = passedCafeObject?.name
    }
    
    @IBAction func openMapsButtonTapped(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Open Location",
                                            message: "How you want to open?",
                                            preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let splitetStringName = passedCafeObject?.name.components(separatedBy: " ")
        guard let nameJoined = splitetStringName!
            .joined(separator: "+")
            .addingPercentEncoding(withAllowedCharacters:
                .urlHostAllowed)
        else {
            fatalError("Hotelname not found")
        }
        let latitude = String(format: "%.6f", (passedCafeObject?.latitude)!)
        let longitude = String(format: "%.6f", (passedCafeObject?.longitude)!)

        // Google Maps
        let actionGoogleMaps = UIAlertAction(title: "Google Maps", style: .default) { _ in

            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                // ?q=Pizza&center=37.759748,-122.427135
                let url = URL(string: "comgooglemaps://?daddr=\(nameJoined)&center=\(latitude),\(longitude)")!
                print(url)
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
        present(actionSheet, animated: true, completion: nil)
    }
    
    

    // Both objc functions are handling the kayboard when typing in a message.
    @objc func keyboardWillShow(_noti: NSNotification) {
        let keyBoard = _noti.userInfo
        let keyBoardValue = keyBoard![UIResponder.keyboardFrameEndUserInfoKey]
        let fram = keyBoardValue as? CGRect // this is frame

        // Identify Iphone X Familiy because of different keyboard heights..
        var hasTopNotch: Bool {
            if #available(iOS 11.0, tvOS 11.0, *) {
                return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
            }
            return false
        }

        UIView.animate(withDuration: 0.5) {
            if hasTopNotch {
                self.heightConstraint.constant = fram!.height + 16
            } else {
                self.heightConstraint.constant = fram!.height + 50
            }
            self.view.layoutIfNeeded()
            let scrollPoint = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height)
            self.tableView.setContentOffset(scrollPoint, animated: false)
        }
    }

    @objc func keyboardWillHide(_noti _: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
            self.tableView.setContentOffset(.zero, animated: false)
        }
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    // So the keyboard disappears when there is a click outside the textfield
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }

    // which buttons have to be highlighted (depending on the data in firestore)
    func activateButtons() {
        if passedCafeObject?.features!["wifi"] == true {
            wifiButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            wifiButton.borderWidth = 2
            wifiLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["food"] == true {
            foodButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            foodButton.borderWidth = 2
            foodLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["vegan"] == true {
            veganButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            veganButton.borderWidth = 2
            veganLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["cake"] == true {
            cakeButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            cakeButton.borderWidth = 2
            cakeLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
        if passedCafeObject?.features!["plugin"] == true {
            plugButton.customBGColor = UIColor(red: 236 / 255, green: 240 / 255, blue: 241 / 255, alpha: 1)
            plugButton.borderWidth = 2
            plugLabel.font = UIFont(name: "Quicksand-Bold", size: 15)
        }
    }

    // Showing and handeling location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }

    @IBAction func toLocationButtonTapped(_: UIButton) {
        let actionSheet = UIAlertController(title: "Open Location",
                                            message: "How you want to open?",
                                            preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let splitetStringName = passedCafeObject?.name.components(separatedBy: " ")
        guard let nameJoined = splitetStringName!
            .joined(separator: "+")
            .addingPercentEncoding(withAllowedCharacters:
                .urlHostAllowed)
        else {
            fatalError("Hotelname not found")
        }
        let latitude = String(format: "%.6f", (passedCafeObject?.latitude)!)
        let longitude = String(format: "%.6f", (passedCafeObject?.longitude)!)

        // Google Maps
        let actionGoogleMaps = UIAlertAction(title: "Google Maps", style: .default) { _ in

            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                // ?q=Pizza&center=37.759748,-122.427135
                let url = URL(string: "comgooglemaps://?daddr=\(nameJoined)&center=\(latitude),\(longitude)")!
                print(url)
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
        present(actionSheet, animated: true, completion: nil)
    }
}
