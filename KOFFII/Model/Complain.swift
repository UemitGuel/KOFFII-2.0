import Foundation

struct Complain {
    let name: String
    let complainCategory: BrewingMethode.complainCategory
    let improvements: [String]
}

let coffeeTooBitter = Complain(name: L10n.coffeeTooBitter,
                               complainCategory: .coffee,
                               improvements: [
                                L10n.coffeeTooBitter1,
                                L10n.coffeeTooBitter2,
                                L10n.coffeeTooBitter3,
                                L10n.coffeeTooBitter4])

let coffeeTooSour = Complain(name: L10n.coffeeTooSour,
                             complainCategory: .coffee,
                             improvements: [
                                L10n.coffeeTooSour1,
                                L10n.coffeeTooSour2,
                                L10n.coffeeTooSour3,
                                L10n.coffeeTooSour4,
                                L10n.coffeeTooSour5])

let espressoTooBitter = Complain(name: L10n.espressoTooBitter,
                               complainCategory: .espresso,
                               improvements: [
                                L10n.espressoTooBitter1,
                                L10n.espressoTooBitter2,
                                L10n.espressoTooBitter3,
                                L10n.espressoTooBitter4,
                                L10n.espressoTooBitter5,
                                L10n.espressoTooBitter6])

let espressoTooSour = Complain(name: L10n.espressoTooSour,
                               complainCategory: .coffee,
                               improvements: [
                                L10n.espressoTooSour1,
                                L10n.espressoTooSour2,
                                L10n.espressoTooSour3,
                                L10n.espressoTooSour4,
                                L10n.espressoTooSour5,
                                L10n.espressoTooSour6])
