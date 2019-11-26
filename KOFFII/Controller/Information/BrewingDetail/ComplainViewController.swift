import UIKit

class ComplainViewController: UIViewController {
    var complain : Complain?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var complainLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()

        complainLabel.text = complain?.name
    }

    func setupViewController() {
        // eliminate 1pt line
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}

extension ComplainViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let complainCount = complain?.improvements.count else { return 0 }
        return complainCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComplainTableViewCell.cellId,
                                                       for: indexPath) as? ComplainTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.complainLabel.text = complain?.improvements[indexPath.row]
        return cell
    }
}
