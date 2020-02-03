import SwiftUI
import Combine

struct CafeList: View {
    @ObservedObject var model: CafeModel
    
    var body: some View {
        List {
            ForEach(model.cafes) { cafe in
                NavigationLink(destination: CafeDetail(cafe: cafe)) {
                    CafeCell(cafe: cafe)
                        .frame(height: 100.0)
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
        HStack {
            Image("coffee_icon")
                .font(.title)
            VStack(alignment: .leading) {
                Text(cafe.name)
                    .font(.system(.headline, design: .rounded))
                Text(cafe.neighborhood.rawValue)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.secondary)

            }
        }
    }
}
