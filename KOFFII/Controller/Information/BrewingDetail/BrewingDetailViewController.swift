import UIKit

class BrewingDetailViewController: UIViewController {
    @IBOutlet var headerImageView: UIImageView!

    @IBOutlet var tableView: UITableView!

    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!

    var complain: Complain?

    var passedInformationBrewing: Information?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableViewHeader()
        setupComplainButton()
    }

    func setupViewController() {
        tabBarController?.tabBar.isHidden = true
        title = passedInformationBrewing?.name
    }

    func setupTableViewHeader() {
        headerImageView.image = passedInformationBrewing?.image
    }
    
    func setupComplainButton() {
        if let passedCategory = passedInformationBrewing?.complainCategory {
            if passedCategory == .coffee {
                rightButton.setTitle(L10n.coffeeTooSour, for: .normal)
                leftButton.setTitle(L10n.coffeeTooBitter, for: .normal)
            } else {
                rightButton.setTitle(L10n.espressoTooSour, for: .normal)
                leftButton.setTitle(L10n.espressoTooBitter, for: .normal)
            }
        } else {
            rightButton.setTitle("", for: .normal)
            leftButton.setTitle("", for: .normal)
        }
    }

    @IBAction func complainButtonTapped(_ sender: UIButton) {
        let complainCategory = passedInformationBrewing?.complainCategory
        if complainCategory == .coffee && sender.tag == 0 {
            complain = coffeeTooBitter
        } else if complainCategory == .coffee && sender.tag == 1 {
            complain = coffeeTooSour
        } else if complainCategory == .espresso && sender.tag == 0 {
            complain = espressoTooBitter
        } else if complainCategory == .espresso && sender.tag == 1 {
            complain = espressoTooSour
        }
        performSegue(withIdentifier: "fromDetailToComplainSegue", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "fromDetailToComplainSegue" {
            let complainVC = segue.destination as! ComplainViewController
            complainVC.complain = complain
        }
    }
}

extension BrewingDetailViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return passedInformationBrewing!.tips.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformationDetailTableViewCell",
                                                 for: indexPath) as! InformationDetailTableViewCell
        guard let information = passedInformationBrewing else {
            return cell
        }

        cell.countLabel.text = String(indexPath.row + 1)
        cell.longTextLabel.text = information.tips[indexPath.row]
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
