import UIKit

struct Information: Identifiable {
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

// MARK: - Brewing Methods Init
let pourOver = Information(name: L10n.pourOver, image: Asset.handfilter.image,
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
                              complainCategory: Information.complainCategory.coffee )

let aeropress = Information(name: L10n.aeropress, image: Asset.aeropress.image,
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
                               complainCategory: Information.complainCategory.coffee )

let bialetti = Information(name: L10n.bialetti, image: Asset.espressokocher.image,
                              quan: L10n.bialettiQuantity,
                              temp: L10n.bialettiTemperature,
                              time: L10n.bialettiBrewingTime,
                              tips: [L10n.bialetti1,
                                     L10n.bialetti2,
                                     L10n.bialetti3,
                                     L10n.bialetti4,
                                     L10n.bialetti5,
                                     L10n.bialetti6 ],
                              complainCategory: Information.complainCategory.espresso )


let chemex = Information(name: L10n.chemex, image: Asset.chemex.image,
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
                            complainCategory: Information.complainCategory.coffee )

let espresso = Information(name: L10n.espresso, image: Asset.espresso.image,
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
                              complainCategory: Information.complainCategory.espresso )

let frenchPress = Information(name: L10n.frenchPress, image: Asset.frenchpress.image,
                                 quan: L10n.frenchPressQuantity,
                                 temp: L10n.frenchPressTemperature,
                                 time: L10n.frenchPressBrewingTime,
                                 tips: [L10n.frenchPress1,
                                        L10n.frenchPress2,
                                        L10n.frenchPress3,
                                        L10n.frenchPress4,
                                        L10n.frenchPress5,
                                        L10n.frenchPress6 ],
                                 complainCategory: Information.complainCategory.coffee )

let turkishMocha = Information(name: L10n.turkishMocha, image: Asset.turkishMocha.image,
                                  quan: L10n.turkishMochaQuantity,
                                  temp: L10n.turkishMochaTemperature,
                                  time: L10n.turkishMochaBrewingTime,
                                  tips: [L10n.turkishMocha1,
                                         L10n.turkishMocha2,
                                         L10n.turkishMocha3,
                                         L10n.turkishMocha4,
                                         L10n.turkishMocha5,
                                         L10n.turkishMocha6 ],
                                  complainCategory: Information.complainCategory.coffee )

// MARK: - Knowledge Init
let coffeeWater = Information(name: L10n.coffeeWater, image: Asset.water.image, quan: nil, temp: nil, time: nil,
                            tips: [
                                L10n.coffeeWater1,
                                L10n.coffeeWater2,
                                L10n.coffeeWater3], complainCategory: nil)

let health = Information(name: L10n.coffeeHealth, image: Asset.health.image,  quan: nil, temp: nil, time: nil,
                       tips: [
                        L10n.coffeeHealth1,
                        L10n.coffeeHealth2,
                        L10n.coffeeHealth3,
                        L10n.coffeeHealth4,
                        L10n.coffeeHealth5], complainCategory: nil)

let history = Information(name: L10n.historyOfCoffee, image: Asset.history.image,  quan: nil, temp: nil, time: nil,
                        tips: [
                            L10n.historyOfCoffee1,
                            L10n.historyOfCoffee2,
                            L10n.historyOfCoffee3,
                            L10n.historyOfCoffee4,
                            L10n.historyOfCoffee5,
                            L10n.historyOfCoffee6], complainCategory: nil)

let fabrication = Information(name: L10n.fabrication, image: Asset.fabrication.image,  quan: nil, temp: nil, time: nil,
                            tips: [
                                L10n.fabrication1,
                                L10n.fabrication2,
                                L10n.fabrication3,
                                L10n.fabrication4,
                                L10n.fabrication5,
                                L10n.fabrication6,
                                L10n.fabrication7,
                                L10n.fabrication8,
                                L10n.fabrication9,
                                L10n.fabrication10], complainCategory: nil)

let regions = Information(name: L10n.regions, image: Asset.regions.image,  quan: nil, temp: nil, time: nil,
                        tips: [
                            L10n.regions1,
                            L10n.regions2,
                            L10n.regions3,
                            L10n.regions4,
                            L10n.regions5,
                            L10n.regions6,
                            L10n.regions7,
                            L10n.regions8,
                            L10n.regions9,
                            L10n.regions10,
                            L10n.regions11,
                            L10n.regions12,
                            L10n.regions13,
                            L10n.regions14,
                            L10n.regions15,
                            L10n.regions16], complainCategory: nil)

let storage = Information(name: L10n.storage, image: Asset.storage.image,  quan: nil, temp: nil, time: nil,
                        tips: [
                            L10n.storage1,
                            L10n.storage2,
                            L10n.storage3,
                            L10n.storage4], complainCategory: nil)
