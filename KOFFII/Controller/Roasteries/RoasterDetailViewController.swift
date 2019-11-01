import FirebaseFirestore
import MapKit
import SVProgressHUD
import UIKit

class RoasterDetailViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!

    @IBOutlet var roasterCommentsTableView: UITableView!
    @IBOutlet var sendButton: UIButton!

    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var heightConstraint: NSLayoutConstraint!

    var passedRoastery: Roastery?
    let regionRadius: CLLocationDistance = 1000

    var messages: [Message] = [Message]()
    var db: Firestore!
    let myGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        title = passedRoastery?.name

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_noti:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_noti:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)

        // Register MessagingCell
        roasterCommentsTableView.register(UINib(nibName: "CustomMessageCell",
                                                bundle: nil),
                                          forCellReuseIdentifier: "customMessageCell")
        configureTableView()

        // Adding TapGesture for Textfield
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        roasterCommentsTableView.addGestureRecognizer(tapGesture)

        retrieveMessages()

        // set map
        let location = CLLocation(latitude: passedRoastery?.latitude ?? 0, longitude: passedRoastery?.longitude ?? 0)
        centerMapOnLocation(location: location)
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    // Showing and handeling location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // So the keyboard disappears when there is a click outside the textfield
    @objc func tableViewTapped() {
        commentTextField.endEditing(true)
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
            let scrollPoint = CGPoint(x: 0, y: self.roasterCommentsTableView.contentSize.height - self.roasterCommentsTableView.frame.size.height)
            self.roasterCommentsTableView.setContentOffset(scrollPoint, animated: false)
        }
    }

    @objc func keyboardWillHide(_noti _: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
            self.roasterCommentsTableView.setContentOffset(.zero, animated: false)
        }
    }

    func retrieveMessages() {
        messages.removeAll()
        SVProgressHUD.show()
        let ref = db.collection("Roastery").document(passedRoastery!.name).collection("Messages")

        // Before downloading the messages, let´s order them for creation date
        // HERE: The Order Function doesnt work!
        ref.order(by: "created", descending: true).getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.myGroup.enter()
                    print("\(document.documentID) => \(document.data())")
                    ref.document(document.documentID).getDocument { document, _ in
                        if let messageObject = document.flatMap({
                            $0.data().flatMap { data in
                                Message(dictionary: data)
                            }
                        }) {
                            print("Message Object: \(messageObject)")
                            self.messages.append(messageObject)
                            self.myGroup.leave()
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                self.myGroup.notify(queue: .main) {
                    print("Finished all requests.")
                    self.messages = self.messages.sorted(by: { $1.timeStamp!.dateValue() > $0.timeStamp!.dateValue() })
                    print("adkmskmakd \(self.messages)")
                    self.configureTableView()
                    self.roasterCommentsTableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
        }
    }

    @IBAction func openMapsButtonTapped(_: UIButton) {
        let actionSheet = UIAlertController(title: "Open Location",
                                            message: "How you want to open?",
                                            preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let splitetStringName = passedRoastery?.name.components(separatedBy: " ")
        guard let nameJoined = splitetStringName!
            .joined(separator: "+")
            .addingPercentEncoding(withAllowedCharacters:
                .urlHostAllowed)
        else {
            fatalError("Hotelname not found")
        }
        let latitude = String(format: "%.6f", (passedRoastery?.latitude)!)
        let longitude = String(format: "%.6f", (passedRoastery?.longitude)!)

        // Google Maps
        let modeGM = "directionsmode=driving"
        let actionGoogleMaps = UIAlertAction(title: "Google Maps", style: .default) { _ in

            if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
                // ?q=Pizza&center=37.759748,-122.427135
                let url = URL(string: "comgooglemaps://?daddr=\(nameJoined)&center=\(latitude),\(longitude)&\(modeGM)")!
                print(url)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://")
            }
        }
        // Apple Maps
        let modeAM = "dirflg=c" // c=car
        let actionAppleMaps = UIAlertAction(title: "Apple Maps", style: .default) { _ in
            let coreUrl = "http://maps.apple.com/?"
            guard let url = URL(string: coreUrl +
                "q=\(nameJoined)&sll=" +
                latitude + "," + longitude +
                "&\(modeAM)&t=s")
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

    @IBAction func sendButtonTapped(_: UIButton) {
        SVProgressHUD.show()

        commentTextField.endEditing(true)
        commentTextField.isEnabled = false
        sendButton.isEnabled = false

        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)

        let sentDate = "\(day).\(month), \(year)"
        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        print(passedRoastery!.name)
        db.collection("Roastery").document(passedRoastery!.name).collection("Messages").document().setData([
            "author": username,
            "date": sentDate,
            "message": commentTextField.text ?? "",
            "created": FieldValue.serverTimestamp(),
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
                SVProgressHUD.dismiss()
            } else {
                print("Document successfully written!")
                SVProgressHUD.dismiss()
                self.commentTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.commentTextField.text = ""
                self.retrieveMessages()
            }
        }
    }
}

extension RoasterDetailViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell",
                                                 for: indexPath) as! CustomMessageCell
        cell.selectionStyle = .none
        cell.nameLabel.text = messages[indexPath.row].author
        cell.dateLabel.text = messages[indexPath.row].date
        cell.commentLabel?.text = messages[indexPath.row].message

        let username = UserDefaults.standard.string(forKey: "username") ?? ""
        if messages[indexPath.row].author == username {
            cell.messageBackgroundView.backgroundColor = UIColor(red: 220 / 255,
                                                                 green: 248 / 255,
                                                                 blue: 198 / 255,
                                                                 alpha: 1)
            cell.leftSideContraint.constant = 24
            cell.rightSideConstraint.constant = 8
        } else {
            cell.messageBackgroundView.backgroundColor = UIColor(red: 236 / 255,
                                                                 green: 240 / 255,
                                                                 blue: 241 / 255,
                                                                 alpha: 1)
            cell.leftSideContraint.constant = 8
            cell.rightSideConstraint.constant = 24
        }
        return cell
    }

    func configureTableView() {
        roasterCommentsTableView.rowHeight = UITableView.automaticDimension
        roasterCommentsTableView.estimatedRowHeight = 120.0
    }
}

extension RoasterDetailViewController: UITableViewDelegate {}
