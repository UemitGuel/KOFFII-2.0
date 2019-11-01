import UIKit

class ComplainViewController: UIViewController {

    var passedComplainObject: Complain?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var complainLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()

        complainLabel.text = passedComplainObject?.name
    }
    
    func setupViewController() {
        // eliminate 1pt line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

}

extension ComplainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedComplainObject?.improvements?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "complainCell", for: indexPath) as? ComplainTableViewCell
        cell?.complainLabel.text = passedComplainObject?.improvements?[indexPath.row]
        return cell!
    }
    
    
}


