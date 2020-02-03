import SwiftUI

struct CafeDetail: View {
    let cafe: Cafe
    
    var body: some View {
        VStack {
            WatchMapView(cafe: cafe)
                .padding()
            HStack {
                if cafe.hasWifi {
                    featureImage(imageName: "WIFI")
                }
                if cafe.hasFood {
                    featureImage(imageName: "FOOD")
                }
                if cafe.hasVegan {
                    featureImage(imageName: "VEGAN")
                }
                if cafe.hasCake {
                    featureImage(imageName: "CAKE")
                }
                if cafe.hasPlug {
                    featureImage(imageName: "PLUG")
                }
            }
            .navigationBarTitle(Text(cafe.name))
        }
    }
}


struct CafeDetail_Previews: PreviewProvider {
    static var previews: some View {
        CafeDetail(cafe: Cafe.previewCafe)
    }
}

struct featureImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .padding(12)
            .background(Color.red)
            .clipShape(Circle())
    }
}
