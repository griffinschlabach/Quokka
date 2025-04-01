//
//  Housing View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/19/25.
//

import SwiftUI

struct Housing_View: View {
    @Binding var userStart: UserData
    @State var isFreeStandNoWater: Bool = false
    @State var isFreeStandWater: Bool = false
    @State var isApartment: Bool = false
    @State var isDuplex: Bool = false
    @State var isCondo: Bool = false
    
    var body: some View {
        VStack {
            Text("What is your housing type?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
                .bold()
            
            Toggle("Freestanding house (no running water)", isOn: $isFreeStandNoWater)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isFreeStandNoWater) { newValue in
                    if newValue {
                        userStart.baseHousingEmissions = 1200
                        // Reset the other toggles
                        isFreeStandWater = false
                        isApartment = false
                        isDuplex = false
                        isCondo = false
                    }
                }
            
            Toggle("Freestanding house (running water)", isOn: $isFreeStandWater)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isFreeStandWater) { newValue in
                    if newValue {
                        userStart.baseHousingEmissions = 4500
                        isFreeStandNoWater = false
                        isApartment = false
                        isDuplex = false
                        isCondo = false
                    }
                }
            
            Toggle("Multi-storey apartment", isOn: $isApartment)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isApartment) { newValue in
                    if newValue {
                        userStart.baseHousingEmissions = 3200
                        isFreeStandNoWater = false
                        isFreeStandWater = false
                        isDuplex = false
                        isCondo = false
                    }
                }
            
            Toggle("Duplex/row house", isOn: $isDuplex)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isDuplex) { newValue in
                    if newValue {
                        userStart.baseHousingEmissions = 3800
                        isFreeStandNoWater = false
                        isFreeStandWater = false
                        isApartment = false
                        isCondo = false
                    }
                }
            
            Toggle("Luxury condo", isOn: $isCondo)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isCondo) { newValue in
                    if newValue {
                        userStart.baseHousingEmissions = 6000
                        isFreeStandNoWater = false
                        isFreeStandWater = false
                        isApartment = false
                        isDuplex = false
                    }
                }
        }
    }
}

#Preview {
    Housing_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
