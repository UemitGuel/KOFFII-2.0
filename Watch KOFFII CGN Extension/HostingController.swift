import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<CafeList> {
    override var body: CafeList {
        return CafeList(model: CafeModel())
    }
}
