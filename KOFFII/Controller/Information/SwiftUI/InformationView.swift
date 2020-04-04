
import SwiftUI

struct InformationView: View {
    
    @State private var showKnowledge = false
    @State private var categoryIndex = 0
    var category = ["Brewing", "Knowledge"]
    
    
    var brewingMethods : [BrewingMethod] = [aeropress,bialetti,chemex,espresso,frenchPress,pourOver,turkishMocha]
    var coffeeKnowledge : [CoffeeKnowledge] = [coffeeWater,health,history,fabrication,regions,storage]
    
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    Picker(selection: $categoryIndex, label: Text("What is your favorite color?")) {
                        ForEach(0..<category.count) { index in
                            Text(self.category[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom)
                    if categoryIndex == 0 {
                        ForEach(brewingMethods) { method in
                            BrewingMethodeCard(method: method)
                                .padding(.bottom)
                        }
                    } else {
                        ForEach(coffeeKnowledge) { knowledge in
                            CoffeeKnowledgeCard(coffeeKnowledge: knowledge)
                                .padding(.bottom)
                        }
                    }
                }
            }
            .navigationBarTitle("About Coffee")
        }
    }
}



struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
