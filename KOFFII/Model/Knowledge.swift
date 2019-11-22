import UIKit

struct Knowledge {
    let name: String
    let imageName: UIImage
    let points: [String]
}

let coffeeWater = Knowledge(name: L10n.coffeeWater, imageName: Asset.water.image,
                            points: [
                                L10n.coffeeWater1,
                                L10n.coffeeWater2,
                                L10n.coffeeWater3])

let health = Knowledge(name: L10n.coffeeHealth, imageName: Asset.health.image,
                       points: [
                        L10n.coffeeHealth1,
                        L10n.coffeeHealth2,
                        L10n.coffeeHealth3,
                        L10n.coffeeHealth4,
                        L10n.coffeeHealth5])

let history = Knowledge(name: L10n.historyOfCoffee, imageName: Asset.history.image,
                        points: [
                            L10n.historyOfCoffee1,
                            L10n.historyOfCoffee2,
                            L10n.historyOfCoffee3,
                            L10n.historyOfCoffee4,
                            L10n.historyOfCoffee5,
                            L10n.historyOfCoffee6])

let fabrication = Knowledge(name: L10n.fabrication, imageName: Asset.fabrication.image,
                            points: [
                                L10n.fabrication1,
                                L10n.fabrication2,
                                L10n.fabrication3,
                                L10n.fabrication4,
                                L10n.fabrication5,
                                L10n.fabrication6,
                                L10n.fabrication7,
                                L10n.fabrication8,
                                L10n.fabrication9,
                                L10n.fabrication10])

let regions = Knowledge(name: L10n.regions, imageName: Asset.regions.image,
                        points: [
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
                            L10n.regions16])

let storage = Knowledge(name: L10n.storage, imageName: Asset.storage.image,
                        points: [
                            L10n.storage1,
                            L10n.storage2,
                            L10n.storage3,
                            L10n.storage4])
