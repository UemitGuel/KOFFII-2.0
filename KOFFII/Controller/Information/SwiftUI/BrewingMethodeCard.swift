import SwiftUI

struct BrewingMethodeCard : View {
    var method = BrewingMethod(name: L10n.coffeeWater, image: Asset.water.image, quan: nil, temp: nil, time: nil,
                             tips: [
                                L10n.coffeeWater1,
                                L10n.coffeeWater2,
                                L10n.coffeeWater3], complainCategory: nil)
    
    var body: some View {
        return VStack(alignment: .leading) {
            Spacer()
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 70)
                HStack {
                    Text(method.name)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding(.leading)
                    Spacer()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.45)
        .background(
            Image(uiImage: method.image)
                .resizable()
                .renderingMode(.original)
                .scaledToFill())
            .cornerRadius(20)
    }
}

struct BrewingMethodeCard_Previews: PreviewProvider {
    static var previews: some View {
        BrewingMethodeCard()
    }
}
