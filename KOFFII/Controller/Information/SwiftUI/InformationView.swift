
import SwiftUI

struct InformationView: View {
    
    var brewingMethodes : [Information] = [aeropress,bialetti,chemex,espresso,frenchPress,pourOver,turkishMocha]
    var knowledge : [Information] = [coffeeWater,health,history,fabrication,regions,storage]
    
    
    var body: some View {
        NavigationView {
            List {
                Text("Brewing")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.leading, 50)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(brewingMethodes) { method in
                            GeometryReader { geometry in
                                NavigationLink(destination: InformationViewDetail(method: method)) {
                                    CardView(method: method)
                                        .rotation3DEffect(Angle(degrees: Double(
                                            (geometry.frame(in: .global).minX - 30) / -30
                                        )), axis: (x: 0, y: 10, z: 0))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: 360)
                        }
                    }.padding(30)
                }
                Text("Brewing")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.leading, 50)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(knowledge) { method in
                            GeometryReader { geometry in
                                NavigationLink(destination: InformationViewDetail(method: method)) {
                                    CardView(method: method)
                                        .rotation3DEffect(Angle(degrees: Double(
                                            (geometry.frame(in: .global).minX - 30) / -30
                                        )), axis: (x: 0, y: 10, z: 0))
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: 360)
                        }
                    }.padding(30)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}


struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}

struct CardView : View {
    var method = Information(name: L10n.coffeeWater, image: Asset.water.image, quan: nil, temp: nil, time: nil,
                             tips: [
                                L10n.coffeeWater1,
                                L10n.coffeeWater2,
                                L10n.coffeeWater3], complainCategory: nil)
    
    var body: some View {
        return VStack(alignment: .leading) {
            Text(method.name)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .lineSpacing(6)
                .lineLimit(4)
                .padding(30)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: 360)
        .background(
            Image(uiImage: method.image)
                .resizable()
                .renderingMode(.original)
                .scaledToFill())
            .cornerRadius(30)
            .shadow(color: Color.gray,radius: 20, x: 0, y: 20)
    }
}
