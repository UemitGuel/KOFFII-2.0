
import SwiftUI

struct InformationView: View {
    
    var brewingMethods : [BrewingMethod] = [aeropress,bialetti,chemex,espresso,frenchPress,pourOver,turkishMocha]
    var coffeeKnowledge : [CoffeeKnowledge] = [coffeeWater,health,history,fabrication,regions,storage]
    
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List {
                BrewingMethodRow(brewingMethods: brewingMethods)
                Divider()
                CoffeeKnowledgeRow(coffeeKnowledge: coffeeKnowledge)
                Spacer()
            }
            .navigationBarTitle("HowTo", displayMode: .inline)
            
        }
    }
}



struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
