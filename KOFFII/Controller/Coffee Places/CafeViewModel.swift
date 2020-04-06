import RealmSwift
import Foundation

struct CafeViewModel {
    private var model: Cafe
    private var modelList: [Cafe]
    
    init(model: Cafe, modelList: [Cafe]) {
        self.model = model
        self.modelList = modelList
    }
    
    var title: String {
        return model.name
    }
}
