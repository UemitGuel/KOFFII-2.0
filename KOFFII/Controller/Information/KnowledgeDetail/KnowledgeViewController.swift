import UIKit

class KnowledgeDetailViewController: UIViewController {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var tableView: UITableView!

    var passedInformationKnowledge: Information?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupHeaderView()
    }

    // MARK: - Setup ViewController/Header

    func setupViewController() {
        tabBarController?.tabBar.isHidden = true
        title = passedInformationKnowledge?.name
    }

    func setupHeaderView() {
        headerImageView.image = passedInformationKnowledge?.image
    }
}

extension KnowledgeDetailViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let count = passedInformationKnowledge?.tips.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        cell.textLabel?.text = passedInformationKnowledge?.tips[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(systemName: "\(indexPath.row + 1).square", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        cell.imageView?.tintColor = .label
        return cell
    }
}

extension KnowledgeDetailViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        if passedInformationKnowledge?.quan != nil {
            return 100
        } else {
            return 0
        }
    }

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        if passedInformationKnowledge?.quan != nil {
            let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
            headerView.quanLabel.text = passedInformationKnowledge?.quan ?? ""
            headerView.tempLabel.text = passedInformationKnowledge?.temp ?? ""
            headerView.timeLabel.text = passedInformationKnowledge?.time ?? ""
            return headerView
        } else {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return view
        }
    }
}
