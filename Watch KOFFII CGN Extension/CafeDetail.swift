import SwiftUI

struct CafeDetail: View {
    let cafe: Cafe
    
    var body: some View {
        VStack {
            Text(cafe.name)
        }
    }
}

struct CafeDetail_Previews: PreviewProvider {
    static var previews: some View {
        CafeDetail(cafe: Cafe.previewCafe)
    }
}
