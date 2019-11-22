import UIKit

struct BrewingMethode {
    let name: String
    let imageName: UIImage
    let quan: String
    let temp: String
    let time: String
    let tips: [String]
    let complainCategory: complainCategory
    
    enum complainCategory {
        case coffee
        case espresso
    }
}

let pourOver = BrewingMethode(name: L10n.pourOver, imageName: Asset.handfilter.image,
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
                              complainCategory: BrewingMethode.complainCategory.coffee )

let aeropress = BrewingMethode(name: L10n.aeropress, imageName: Asset.aeropress.image,
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
                               complainCategory: BrewingMethode.complainCategory.coffee )

let bialetti = BrewingMethode(name: L10n.bialetti, imageName: Asset.espressokocher.image,
                              quan: L10n.bialettiQuantity,
                              temp: L10n.bialettiTemperature,
                              time: L10n.bialettiBrewingTime,
                              tips: [L10n.bialetti1,
                                     L10n.bialetti2,
                                     L10n.bialetti3,
                                     L10n.bialetti4,
                                     L10n.bialetti5,
                                     L10n.bialetti6 ],
                              complainCategory: BrewingMethode.complainCategory.espresso )


let chemex = BrewingMethode(name: L10n.chemex, imageName: Asset.chemex.image,
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
                            complainCategory: BrewingMethode.complainCategory.coffee )

let espresso = BrewingMethode(name: L10n.espresso, imageName: Asset.espresso.image,
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
                              complainCategory: BrewingMethode.complainCategory.espresso )

let frenchPress = BrewingMethode(name: L10n.frenchPress, imageName: Asset.frenchpress.image,
                                 quan: L10n.frenchPressQuantity,
                                 temp: L10n.frenchPressTemperature,
                                 time: L10n.frenchPressBrewingTime,
                                 tips: [L10n.frenchPress1,
                                        L10n.frenchPress2,
                                        L10n.frenchPress3,
                                        L10n.frenchPress4,
                                        L10n.frenchPress5,
                                        L10n.frenchPress6 ],
                                 complainCategory: BrewingMethode.complainCategory.coffee )

let turkishMocha = BrewingMethode(name: L10n.turkishMocha, imageName: Asset.turkishMocha.image,
                                  quan: L10n.turkishMochaQuantity,
                                  temp: L10n.turkishMochaTemperature,
                                  time: L10n.turkishMochaBrewingTime,
                                  tips: [L10n.turkishMocha1,
                                         L10n.turkishMocha2,
                                         L10n.turkishMocha3,
                                         L10n.turkishMocha4,
                                         L10n.turkishMocha5,
                                         L10n.turkishMocha6 ],
                                  complainCategory: BrewingMethode.complainCategory.coffee )


