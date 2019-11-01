import Firebase
import SVProgressHUD
import UIKit

class InformationViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var db: Firestore!
    var informationBrew = [Information]()
    var informationKnow = [Information]()
    let sections = ["Brewing", "Knowledge"]
    var items = [[Information]]()

    let myGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()

        // MARK: Loading Content from FireStore

        SVProgressHUD.show()
        loadAllObjects(fromCollection: "Information_Brewing") { array in
            self.items.append(array)
            self.loadAllObjects(fromCollection: "Information_Knowledge") { array in
                self.items.append(array)
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    // MARK: - Handling the appearence and disappearnce of the Navigation and Tabbar

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Neccessary Functions for Downloading the Objects from the Firestore Server. First we downloading all the DocIDs from a collection. Then we use the IDs to download the data for every Document and put it in the right DataModel

    func loadAllObjects(fromCollection: String, completionHandler: @escaping ([Information]) -> Void) {
        var tempInformation = [Information]()
        getAllDocumentIDs(fromCollection: fromCollection) { ids in
            for id in ids {
                self.myGroup.enter()
                self.useDocumentIDToRetrieveObject(fromCollection: fromCollection, id: id, completionHandler: { object in
                    tempInformation.append(object)
                    self.myGroup.leave()
                })
            }
            self.myGroup.notify(queue: .main) {
                print("Finished all requests.")
                completionHandler(tempInformation)
            }
        }
    }

    func getAllDocumentIDs(fromCollection: String, completionHandler: @escaping ([String]) -> Void) {
        var tempDocIDs = [String]()
        let docRef = db.collection(fromCollection)
        docRef.getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                    tempDocIDs.append(document.documentID)
                }
                completionHandler(tempDocIDs)
            }
        }
    }

    func useDocumentIDToRetrieveObject(fromCollection: String, id: String, completionHandler: @escaping (Information) -> Void) {
        let docRef = db.collection(fromCollection).document(id)

        docRef.getDocument { document, _ in
            if let information = document.flatMap({
                $0.data().flatMap { data in
                    Information(dictionary: data)
                }
            }) {
                completionHandler(information)
            } else {
                print("Document does not exist")
            }
        }
    }
}

// MARK: - DataSource, Delegate

extension InformationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath) as! InformationTableViewCell
        cell.nameLabel?.text = items[indexPath.section][indexPath.row].name
        cell.infoImageView?.image = UIImage(named: items[indexPath.section][indexPath.row].imageName ?? "")
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 220
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "fromInfoToDetailBrewSegue" {
            let detailVC = segue.destination as! BrewingDetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.passedInformationBrewing = items[indexPath.section][indexPath.row]
            }
        } else if segue.identifier == "fromInfoToDetailKnowSegue" {
            let detailVC = segue.destination as! KnowledgeDetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.passedInformationKnowledge = items[indexPath.section][indexPath.row]
            }
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "fromInfoToDetailBrewSegue", sender: self)
        } else if indexPath.section == 1 {
            performSegue(withIdentifier: "fromInfoToDetailKnowSegue", sender: self)
        }
    }

    // MARK: Sections for TableView

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count != 0 {
            return items[section].count
        } else {
            return 0
        }
    }

    func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection _: Int) {
        view.tintColor = .white

        let header = view as! UITableViewHeaderFooterView
        guard let customFont = UIFont(name: "Staatliches-Regular", size: 40) else {
            fatalError("""
            Failed to load the "CustomFont-Light" font.
            Make sure the font file is included in the project and the font name is spelled correctly.
            """
            )
        }
        header.textLabel?.font = UIFontMetrics.default.scaledFont(for: customFont)
        header.backgroundColor = .white
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 60
    }
}
