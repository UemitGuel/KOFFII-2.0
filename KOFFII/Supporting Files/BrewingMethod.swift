import UIKit

struct BrewingMethod: Identifiable {
    var id = UUID()
    let name: String
    let image: UIImage
    let quan: String?
    let temp: String?
    let time: String?
    let tips: [String]
    let complainCategory: complainCategory?
    
    enum complainCategory {
        case coffee
        case espresso
    }
}

struct CoffeeKnowledge: Identifiable {
    var id = UUID()
    let name: String
    let image: UIImage
    let tips: [String]
}

// MARK: - Brewing Methods Init
let pourOver = BrewingMethod(name: L10n.pourOver, image: Asset.handfilter.image,
                              quan: L10n.pourOverQuantity,
                              temp: L10n.pourOverTemperature,
                              time: L10n.pourOverBrewingTime,
                              tips: [L10n.pourOver1,
                                     L10n.pourOver2,
                                     L10n.pourOver3,
                                     L10n.pourOver4,
                                     L10n.pourOver5,
                                     L10n.pourOver6,
                                     L10n.pourOver7,
                                     L10n.pourOver8 ],
                              complainCategory: BrewingMethod.complainCategory.coffee )

let aeropress = BrewingMethod(name: L10n.aeropress, image: Asset.aeropress.image,
                               quan: L10n.aeropressQuantity,
                               temp: L10n.aeropressTemperature,
                               time: L10n.aeropressBrewingTime,
                               tips: [L10n.aeropress1,
                                      L10n.aeropress2,
                                      L10n.aeropress3,
                                      L10n.aeropress4,
                                      L10n.aeropress5,
                                      L10n.aeropress6,
                                      L10n.aeropress7,
                                      L10n.aeropress8,
                                      L10n.aeropress9 ],
                               complainCategory: BrewingMethod.complainCategory.coffee )

let bialetti = BrewingMethod(name: L10n.bialetti, image: Asset.espressokocher.image,
                              quan: L10n.bialettiQuantity,
                              temp: L10n.bialettiTemperature,
                              time: L10n.bialettiBrewingTime,
                              tips: [L10n.bialetti1,
                                     L10n.bialetti2,
                                     L10n.bialetti3,
                                     L10n.bialetti4,
                                     L10n.bialetti5,
                                     L10n.bialetti6 ],
                              complainCategory: BrewingMethod.complainCategory.espresso )


let chemex = BrewingMethod(name: L10n.chemex, image: Asset.chemex.image,
                            quan: L10n.chemexQuantity,
                            temp: L10n.chemexTemperature,
                            time: L10n.chemexBrewingTime,
                            tips: [L10n.chemex1,
                                   L10n.chemex2,
                                   L10n.chemex3,
                                   L10n.chemex4,
                                   L10n.chemex5,
                                   L10n.chemex6,
                                   L10n.chemex7,
                                   L10n.chemex8,
                                   L10n.chemex9 ],
                            complainCategory: BrewingMethod.complainCategory.coffee )

let espresso = BrewingMethod(name: L10n.espresso, image: Asset.espresso.image,
                              quan: L10n.espressoQuantity,
                              temp: L10n.espressoTemperature,
                              time: L10n.espressoBrewingTime,
                              tips: [L10n.espresso1,
                                     L10n.espresso2,
                                     L10n.espresso3,
                                     L10n.espresso4,
                                     L10n.espresso5,
                                     L10n.espresso6,
                                     L10n.espresso7,
                                     L10n.espresso8 ],
                              complainCategory: BrewingMethod.complainCategory.espresso )

let frenchPress = BrewingMethod(name: L10n.frenchPress, image: Asset.frenchpress.image,
                                 quan: L10n.frenchPressQuantity,
                                 temp: L10n.frenchPressTemperature,
                                 time: L10n.frenchPressBrewingTime,
                                 tips: [L10n.frenchPress1,
                                        L10n.frenchPress2,
                                        L10n.frenchPress3,
                                        L10n.frenchPress4,
                                        L10n.frenchPress5,
                                        L10n.frenchPress6 ],
                                 complainCategory: BrewingMethod.complainCategory.coffee )

let turkishMocha = BrewingMethod(name: L10n.turkishMocha, image: Asset.turkishMocha.image,
                                  quan: L10n.turkishMochaQuantity,
                                  temp: L10n.turkishMochaTemperature,
                                  time: L10n.turkishMochaBrewingTime,
                                  tips: [L10n.turkishMocha1,
                                         L10n.turkishMocha2,
                                         L10n.turkishMocha3,
                                         L10n.turkishMocha4,
                                         L10n.turkishMocha5,
                                         L10n.turkishMocha6 ],
                                  complainCategory: BrewingMethod.complainCategory.coffee )
