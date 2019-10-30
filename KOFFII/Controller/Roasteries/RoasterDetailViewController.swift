import UIKit
import MapKit

class RoasterDetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var roasterCommentsTableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    var passedRoastery : Roastery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = passedRoastery?.name
        
    }
    @IBAction func openMapsButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
    }
    
    
}
