import SwiftUI

struct WatchMapView: WKInterfaceObjectRepresentable {
    var cafe: Cafe
    
    func makeWKInterfaceObject(context: WKInterfaceObjectRepresentableContext<WatchMapView>) -> WKInterfaceMap {
        return WKInterfaceMap()
    }
    
    func updateWKInterfaceObject(_ map: WKInterfaceMap, context: WKInterfaceObjectRepresentableContext<WatchMapView>) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02,
                                    longitudeDelta: 0.02)
        
        let region = MKCoordinateRegion(
            center: cafe.coordinates,
            span: span)
        
        map.setRegion(region)
        map.addAnnotation(cafe.coordinates, with: .red)
    }
}

struct WatchMapView_Previews: PreviewProvider {
    static var previews: some View {
        WatchMapView(cafe: Cafe.previewCafe)
    }
}
