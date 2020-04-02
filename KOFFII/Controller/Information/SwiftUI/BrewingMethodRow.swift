//
//  BrewingMethodRow.swift
//  KOFFII
//
//  Created by Ümit Gül on 02.04.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import SwiftUI

struct BrewingMethodRow: View {
    var brewingMethods = [BrewingMethod]()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Brewing")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.leading, 25)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(brewingMethods) { method in
                        GeometryReader { geometry in
                            NavigationLink(destination: BrewingMethodeDetailView(method: method)) {
                                BrewingMethodeCard(method: method)
                                    .rotation3DEffect(Angle(degrees: Double(
                                        (geometry.frame(in: .global).minX - 30) / -30
                                    )), axis: (x: 0, y: 10, z: 0))
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 460)
                    }
                }
            }
        }

    }
}

//struct BrewingMethodRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BrewingMethodRow()
//    }
//}
