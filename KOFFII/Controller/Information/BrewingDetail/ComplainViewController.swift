import UIKit

class ComplainViewController: UIViewController {
    var passedComplainObject: Complain?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var complainLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()

        complainLabel.text = passedComplainObject?.name
    }

    func setupViewController() {
        // eliminate 1pt line
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}

extension ComplainViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return passedComplainObject?.improvements?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "complainCell", for: indexPath) as? ComplainTableViewCell
        cell?.complainLabel.text = passedComplainObject?.improvements?[indexPath.row]
        return cell!
    }
}
