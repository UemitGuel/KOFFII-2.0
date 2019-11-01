import Firebase
import UIKit

class BrewingDetailViewController: UIViewController {
    @IBOutlet var headerImageView: UIImageView!

    @IBOutlet var tableView: UITableView!

    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!

    var db: Firestore!
    var downloadedComplainObject: Complain?
    let myGroup = DispatchGroup()
    let myGrouptwo = DispatchGroup()

    var passedInformationBrewing: Information?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupViewController()
        setupTableViewHeader()
        setupComplainButton()
    }

    // MARK: - Setup Firebase/ViewController/TableViewHeader

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    func setupViewController() {
        tabBarController?.tabBar.isHidden = true
        title = passedInformationBrewing?.name
    }

    func setupTableViewHeader() {
        guard let imageName = passedInformationBrewing?.imageName else { return }
        headerImageView.image = UIImage(named: imageName)
    }

    // MARK: - Setup Complain Buttons. After, downloading the right Complain-Model Object by checking which button is tapped(via tag) and which complainCategory("Coffee" or "Espresso") is choosen, and then the right document from Firestore is downloaded ( Collecton: Complain )

    func setupComplainButton() {
        if let passedCategory = passedInformationBrewing?.complainCatgory {
            if passedCategory == "Coffee" {
                db.collection("Complain").whereField("coffee", arrayContains: true)
                    .getDocuments { querySnapshot, err in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            var docIDs = [String]()
                            self.myGroup.enter()
                            for document in querySnapshot!.documents {
                                self.myGroup.enter()
                                docIDs.append(document.documentID)
                            }
                        }
                    }
                rightButton.setTitle("coffee too sour?", for: .normal)
                leftButton.setTitle("coffee too bitter?", for: .normal)
            } else {
                rightButton.setTitle("espresso too sour?", for: .normal)
                leftButton.setTitle("espresso to bitter?", for: .normal)
            }
        } else {
            rightButton.setTitle("", for: .normal)
            leftButton.setTitle("", for: .normal)
        }
    }

    @IBAction func complainButtonTapped(_ sender: UIButton) {
        guard let complainCategory = passedInformationBrewing?.complainCatgory else { return }
        downloadComplainObject(senderTag: sender.tag, complainCategory: complainCategory) { complain in
            self.downloadedComplainObject = complain
            self.performSegue(withIdentifier: "fromDetailToComplainSegue", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "fromDetailToComplainSegue" {
            let complainVC = segue.destination as! ComplainViewController
            complainVC.passedComplainObject = downloadedComplainObject
        }
    }

    func downloadComplainObject(senderTag: Int, complainCategory: String, completionHandler: @escaping (Complain) -> Void) {
        var tempComplainObject: Complain?
        let collectionRef = db.collection("Complain")
        if complainCategory == "Coffee", senderTag == 0 {
            collectionRef.document("coffee too bitter?").getDocument { document, _ in
                if let complain = document.flatMap({
                    $0.data().flatMap { data in
                        Complain(dictionary: data)
                    }
                }) {
//                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)

                } else {
                    print("Document does not exist")
                }
            }
        } else if complainCategory == "Coffee", senderTag == 1 {
            collectionRef.document("coffee too sour?").getDocument { document, _ in
                if let complain = document.flatMap({
                    $0.data().flatMap { data in
                        Complain(dictionary: data)
                    }
                }) {
//                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)

                } else {
                    print("Document does not exist")
                }
            }
        } else if complainCategory == "Espresso", senderTag == 0 {
            collectionRef.document("espresso too bitter?").getDocument { document, _ in
                if let complain = document.flatMap({
                    $0.data().flatMap { data in
                        Complain(dictionary: data)
                    }
                }) {
//                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)

                } else {
                    print("Document does not exist")
                }
            }
        } else if complainCategory == "Espresso", senderTag == 1 {
            collectionRef.document("espresso too sour?").getDocument { document, _ in
                if let complain = document.flatMap({
                    $0.data().flatMap { data in
                        Complain(dictionary: data)
                    }
                }) {
//                    print("Complain: \(complain)")
                    tempComplainObject = complain
                    completionHandler(tempComplainObject!)

                } else {
                    print("Document does not exist")
                }
            }
        }
    }
}

extension BrewingDetailViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let count = passedInformationBrewing?.tips?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformationDetailTableViewCell",
                                                 for: indexPath) as! InformationDetailTableViewCell
        guard let information = passedInformationBrewing else {
            return cell
        }
        guard let tips = information.tips else {
            return cell
        }
        cell.countLabel.text = String(indexPath.row + 1)
        cell.longTextLabel.text = tips[indexPath.row]
        return cell
    }
}

extension BrewingDetailViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        if passedInformationBrewing?.quan != nil {
            return 100
        } else {
            return 0
        }
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        if passedInformationBrewing?.quan != nil {
            let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView

            headerView.quanLabel.text = passedInformationBrewing?.quan ?? ""
            headerView.tempLabel.text = passedInformationBrewing?.temp ?? ""
            headerView.timeLabel.text = passedInformationBrewing?.time ?? ""
            return headerView
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view
        }
    }
}
