//
//  BrewingMethodeCard.swift
//  KOFFII
//
//  Created by Ümit Gül on 02.04.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import SwiftUI

struct BrewingMethodeCard : View {
    var method = BrewingMethod(name: L10n.coffeeWater, image: Asset.water.image, quan: nil, temp: nil, time: nil,
                             tips: [
                                L10n.coffeeWater1,
                                L10n.coffeeWater2,
                                L10n.coffeeWater3], complainCategory: nil)
    
    var body: some View {
        return VStack(alignment: .leading) {
            Text(method.name)
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
                .lineSpacing(6)
                .lineLimit(4)
                .padding(30)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.7, height: 360)
        .background(
            Image(uiImage: method.image)
                .resizable()
                .renderingMode(.original)
                .scaledToFill())
            .cornerRadius(30)
            .shadow(color: Color.gray,radius: 10, x: 0, y: 10)
    }
}

struct BrewingMethodeCard_Previews: PreviewProvider {
    static var previews: some View {
        BrewingMethodeCard()
    }
}
