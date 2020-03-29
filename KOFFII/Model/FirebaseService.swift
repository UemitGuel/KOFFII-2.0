import FirebaseFirestore
import RealmSwift

class FirebaseService {
    
    let realm = try! Realm()
    let firebaseRef = Firestore.firestore().collection("City").document("Cologne").collection("Cafes")
    
    func fetchCafes() {
        firebaseRef.getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let cafe = Cafe(data)
                    try! self.realm.write {
                        self.realm.add(cafe, update: .modified)
                    }
                }
            }
        }
    }
}
