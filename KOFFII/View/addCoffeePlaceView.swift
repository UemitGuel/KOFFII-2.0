//
//  addCoffeePlaceView.swift
//  KOFFII
//
//  Created by Ümit Gül on 23.01.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import SwiftUI

struct addCoffeePlaceView: View {
    @State private var name = ""
    
    let state = [L10n.yes,L10n.no]
    @State private var selectedWifi = 0
    @State private var selectedFood = 0
    @State private var selectedVegan = 0
    @State private var selectedCake = 0
    @State private var selectedPlug = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(L10n.nameOfTheCoffeePlace)) {
                    TextField("Name", text: $name)
                }
                Section(header: Text(L10n.doTheyHaveWifi)) {
                    Picker("Vegan?", selection: $selectedWifi) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyServeFood)) {
                    Picker("Vegan?", selection: $selectedFood) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyHaveVeganOptions)) {
                    Picker("Vegan?", selection: $selectedVegan) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyHaveCake)) {
                    Picker("Vegan?", selection: $selectedCake) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(L10n.doTheyHavePlugs)) {
                    Picker("Vegan?", selection: $selectedPlug) {
                        ForEach(0 ..< state.count) {
                            Text(self.state[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle(L10n.addANewCoffeePlace)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "paperplane")
                        Text(L10n.send)
                    }
                    .foregroundColor(.red)
                }
            )
        }
    }
}

struct addCoffeePlaceView_Previews: PreviewProvider {
    static var previews: some View {
        addCoffeePlaceView()
    }
}
