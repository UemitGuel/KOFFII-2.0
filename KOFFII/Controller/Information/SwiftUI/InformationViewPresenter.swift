import UIKit
import SwiftUI

class InformationViewPresenter: UIViewController {

    @IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: InformationView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
