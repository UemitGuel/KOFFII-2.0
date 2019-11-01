import FirebaseFirestore
import UIKit

class RoasterViewController: UIViewController {
    var db: Firestore!
    var roasteries: [Roastery] = []

    @IBOutlet var roasterTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupViewController()
        fetchRoasteries { _ in
            self.roasterTableView.reloadData()
        }
    }

    func setupFirebase() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }

    func setupViewController() {
        // eliminate 1pt line
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    private func fetchRoasteries(completionHandler: @escaping ([Roastery]) -> Void) {
        db.collection("Roastery").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let d = document.data()
                    guard let roastery = Roastery(dictionary: d) else { return }
                    self.roasteries.append(roastery)
                }
                completionHandler(self.roasteries)
            }
        }
    }

//    for document in querySnapshot!.documents {
//        let d = document.data()
//        guard let cafe = Cafe(dictionary: d) else { return }
//        print("add cafe \(cafe)")
//        cafeArray.append(cafe)
//    }
//    completionHandler(cafeArray)
}

extension RoasterViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return roasteries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roasteryCell",
                                                 for: indexPath) as! RoasterTableViewCell
        cell.selectionStyle = .none
        cell.roasterLabel.text = roasteries[indexPath.row].name
        return cell
    }
}

extension RoasterViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 93
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        performSegue(withIdentifier: "Roaster to Detail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "Roaster to Detail" {
            let roasteryDetailVC = segue.destination as! RoasterDetailViewController
            if let indexPath = roasterTableView.indexPathForSelectedRow {
                roasteryDetailVC.passedRoastery = roasteries[indexPath.row]
            }
        }
    }
}
