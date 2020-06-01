//
//  CoffeeKnowledgeRow.swift
//  KOFFII
//
//  Created by Ümit Gül on 02.04.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import SwiftUI

struct CoffeeKnowledgeRow: View {
    
    var coffeeKnowledge = [CoffeeKnowledge]()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Knowledge")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .padding(.leading, 50)
            ScrollView(.horizontal,showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(coffeeKnowledge) { knowledge in
                        GeometryReader { geometry in
                            NavigationLink(destination: CoffeeKnowledgeDetailView(coffeeKnowledge: knowledge)) {
                                CoffeeKnowledgeCard(coffeeKnowledge: knowledge)
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

struct BrewingMethodRow_Previews: PreviewProvider {
    static var previews: some View {
        BrewingMethodRow()
    }
}
