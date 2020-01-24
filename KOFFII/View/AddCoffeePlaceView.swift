import SwiftUI
import FirebaseFirestore
import SVProgressHUD

struct AddCoffeePlaceView: View {
    var dismiss: () -> Void
    @State private var name = ""
    
    let state = [L10n.yes,L10n.no]
    @State private var selectedWifi = 0
    @State private var selectedFood = 0
    @State private var selectedVegan = 0
    @State private var selectedCake = 0
    @State private var selectedPlug = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(L10n.nameOfTheCoffeePlace)) {
                    TextField("Name", text: $name)
                }
                Section(header: Text(L10n.doTheyHaveWifi)) {
                    Picker("Vegan?", selection: $selectedWifi) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyServeFood)) {
                    Picker("Vegan?", selection: $selectedFood) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyHaveVeganOptions)) {
                    Picker("Vegan?", selection: $selectedVegan) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyHaveCake)) {
                    Picker("Vegan?", selection: $selectedCake) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyHavePlugs)) {
                    Picker("Vegan?", selection: $selectedPlug) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle(L10n.newCoffeePlace)
            .navigationBarItems(trailing:
                Button(action: {
                    self.addPlaceToFirebase()
                    SVProgressHUD.showSuccess(withStatus: L10n.coffeePlaceSentForReview)
                    self.dismiss()
                }) {
                    HStack {
                        Image(systemName: "paperplane")
                        Text(L10n.send)
                    }
                    .foregroundColor(.red)
                }
            )
        }
    }
    
    private func addPlaceToFirebase() {
        var ref: DocumentReference?
        ref = Constants.refs.firestoreAddCoffeeCollection
            .addDocument(data: [
                "name": "\(self.name)",
            "wifi": "\(self.selectedWifi)",
            "food": "\(self.selectedFood)",
            "vegan": "\(self.selectedVegan)",
            "cake": "\(self.selectedCake)",
            "plug": "\(self.selectedPlug)",
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}

//struct addCoffeePlaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        addCoffeePlaceView()
//    }
//}
