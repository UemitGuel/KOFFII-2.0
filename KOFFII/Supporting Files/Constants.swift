import Firebase

struct Constants {
    struct refs {
        static let firestoreRoot = Firestore.firestore()
        static let firestoreCologneCafes = firestoreRoot.collection("City").document("Cologne").collection("Cafes")
        static let firestoreAddCoffeeCollection = firestoreRoot.collection("AddedCoffeePlaces")
        static let firestoreRoasteries = firestoreRoot.collection("Roastery")
    }
}
