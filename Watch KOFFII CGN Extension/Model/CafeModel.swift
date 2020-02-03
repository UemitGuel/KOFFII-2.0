import Combine
import UIKit
import CoreLocation

extension Int: Identifiable {
    public var id: Int {
        self
    }
}

struct Cafe: Identifiable {
    var id: String {
        name
    }
    
    let name: String
    let coordinates: CLLocationCoordinate2D
    let locationURL: String?
    let neighborhood: Neighborhood
    
    let hasWifi: Bool
    let hasFood: Bool
    let hasVegan: Bool
    let hasCake: Bool
    let hasPlug: Bool
}

enum Neighborhood: String, CaseIterable {
    case deutz = "Deutz/Kalk"
    case lindenthal = "Lindenthal/Sülz"
    case nippes = "Nippes"
    case ehrenfeld = "Ehrenfeld"
    case südstadt = "Südstadt"
    case innenstadt = "Innenstadt"
    case belgisches = "Belgisches Viertel"
    case latin = "Latin Quarter"
}


class CafeModel: ObservableObject {
    
    @Published var cafes: [Cafe] = [
        Cafe(name: "Al Baretto", coordinates: CLLocationCoordinate2D(latitude: 50.9233122, longitude: 6.9247472), locationURL: "https://www.google.com/maps/place/Al+Barretto/@50.9233122,6.9247472,17z/data=!4m16!1m10!2m9!1zY2Fmw6lz!3m6!1zY2Fmw6lz!2zV2V5ZXJ0YWwsIEvDtmxu!3s0x47bf24e4bfd8014b:0x6e754f8019c9f0d6!4m2!1d6.9257635!2d50.9258329!6e5!3m4!1s0x0:0x7dad856db2e91d3e!8m2!3d50.9233086!4d6.9269409", neighborhood: .lindenthal , hasWifi: false, hasFood: true, hasVegan: false, hasCake: true, hasPlug: false),
        Cafe(name: "Angelo Di Fini Cafe Espressino",coordinates: CLLocationCoordinate2D(latitude: 50.9512343, longitude: 6.9552106), locationURL: "https://www.google.de/maps/place/Angelo+Di+Fini+Cafe+Espressino/@50.9512343,6.9552106,17z/data=!3m1!4b1!4m5!3m4!1s0x47bf25a28778424f:0x89a34b53cd85b6d7!8m2!3d50.9512309!4d6.9574046", neighborhood: .nippes, hasWifi: true, hasFood: true, hasVegan: false, hasCake: true, hasPlug: false),
        Cafe(name: "Bambule.Kaffeebar", coordinates: CLLocationCoordinate2D(latitude: 50.9369514, longitude: 7.006572), locationURL: "https://www.google.de/maps/place/Bambule.Kaffeebar/@50.9369514,7.006572,17z/data=!4m12!1m6!3m5!1s0x47bf2670189ef6e5:0x25d077e0f785182!2sKundenzentrum+Kalk+-+Stadt+Köln!8m2!3d50.939315!4d7.0090109!3m4!1s0x47bf267ab6e8fd81:0x2fa936a61a5aa55c!8m2!3d50.9369497!4d7.0087637", neighborhood: .deutz, hasWifi: false, hasFood: true, hasVegan: true, hasCake: true, hasPlug: false)
    ]
    
}

extension Cafe {
    /// A sample topic used in the preview.
    static let previewCafe = Cafe(name: "Al Baretto", coordinates: CLLocationCoordinate2D(latitude: 50.9233122, longitude: 6.9247472), locationURL: "https://www.google.com/maps/place/Al+Barretto/@50.9233122,6.9247472,17z/data=!4m16!1m10!2m9!1zY2Fmw6lz!3m6!1zY2Fmw6lz!2zV2V5ZXJ0YWwsIEvDtmxu!3s0x47bf24e4bfd8014b:0x6e754f8019c9f0d6!4m2!1d6.9257635!2d50.9258329!6e5!3m4!1s0x0:0x7dad856db2e91d3e!8m2!3d50.9233086!4d6.9269409", neighborhood: .lindenthal , hasWifi: false, hasFood: true, hasVegan: false, hasCake: true, hasPlug: false)
}
