import SwiftUI
import Combine

struct CafeList: View {
    @ObservedObject var model: CafeModel
    var neighborhoods = ["Alle Viertel","Deutz/Kalk","Lindenthal/Sülz", "Nippes", "Ehrenfeld","Südstadt","Innenstadt", "Belgisches Viertel", "Latin Quarter"]
    
    @State private var choosenHood = 0
    
    var body: some View {
        List {
            Picker(selection: $choosenHood, label: Text("Hood")) {
                ForEach(0 ..< neighborhoods.count) {
                    Text(self.neighborhoods[$0])
                }
            }
            ForEach(model.cafes) { cafe in
                NavigationLink(destination: CafeDetail(cafe: cafe)) {
                    CafeCell(cafe: cafe)
                }
            }
        }
        .listStyle(CarouselListStyle())
        .navigationBarTitle(Text("KOFFII Cologne"))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CafeList(model: CafeModel())
    }
}

struct CafeCell: View {
    var cafe: Cafe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(cafe.name)
                .font(.system(.headline, design: .rounded))
            Text(cafe.neighborhood.rawValue)
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.secondary)
            FeatureImages(cafe: cafe)
        }
    .padding()
    }
}
