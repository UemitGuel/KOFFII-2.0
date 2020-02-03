import SwiftUI

struct CafeDetail: View {
    let cafe: Cafe
    
    var body: some View {
        ScrollView {
            VStack {
                WatchMapView(cafe: cafe)
                    .frame(height: 100)
                CafeCell(cafe: cafe)
            }
            .padding()
        }
    }
}


struct CafeDetail_Previews: PreviewProvider {
    static var previews: some View {
        CafeDetail(cafe: Cafe.previewCafe)
    }
}

struct FeatureImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .frame(width: 20, height: 20)
            .padding(8)
            .background(Color.red)
            .cornerRadius(16)
    }
}

struct FeatureImages: View {
    var cafe: Cafe
    
    var body: some View {
        HStack {
            if cafe.hasWifi {
                FeatureImage(imageName: "WIFI")
            }
            if cafe.hasFood {
                FeatureImage(imageName: "FOOD")
            }
            if cafe.hasPlug {
                FeatureImage(imageName: "PLUG")
            }
        }
    }
}
