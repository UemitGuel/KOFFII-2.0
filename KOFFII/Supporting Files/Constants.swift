import Firebase

struct Constants {
    struct refs {
        static let firestoreRoot = Firestore.firestore()
        static let firestoreCologneCafes = firestoreRoot.collection("City").document("Cologne").collection("Cafes")
        static let firestoreAddCoffeeCollection = firestoreRoot.collection("AddedCoffeePlaces")
        static let firestoreRoasteries = firestoreRoot.collection("Roastery")
    }
    
    struct segues {
        static let citytoDetail = "fromCitytoDetailSegue"
        static let infoToDetailBrew = "fromInfoToDetailBrewSegue"
        static let infoToDetailKnow = "fromInfoToDetailKnowSegue"
        static let detailToComplain = "fromDetailToComplainSegue"
        static let roasterToDetail = "Roaster to Detail"
    }
    
    static func getBlur(view: UIView) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect.init(style: .systemThickMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 16
        blurEffectView.clipsToBounds = true
        blurEffectView.frame = view.bounds
        blurEffectView.isUserInteractionEnabled = false
        return blurEffectView
    }
}
