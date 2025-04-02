//
//  Private Transport View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/24/25.
//

import SwiftUI

struct Private_Transport_View: View {
    @Binding var userStart: UserData
    @State var isGasCar: Bool = false
    @State var isElectricCar: Bool = false
    @State var isMotorcycle: Bool = false
    var body: some View {
        VStack {
            Text("On a weekly basis, which mode of transportation do you use?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
                .bold()
            
            Toggle("Car (gasoline)", isOn: $isGasCar)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isGasCar) { newValue in
                    if newValue {
                        userStart.carEmissionFactor = 0.21
                        isElectricCar = false
                        isMotorcycle = false
                    }
                }
            
            Toggle("Car (electric/hybrid)", isOn: $isElectricCar)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isElectricCar) { newValue in
                    if newValue {
                        userStart.carEmissionFactor = 0.06
                        isGasCar = false
                        isMotorcycle = false
                    }
                }
            
            Toggle("Motorcyle", isOn: $isMotorcycle)
                .font(Constants.mainfont)
                .padding(15)
                .onChange(of: isMotorcycle) { newValue in
                    if newValue {
                        userStart.baseHousingEmissions = 0.1
                        isGasCar = false
                        isElectricCar = false
                    }
                }
            
            Text("How far do you travel each week using this vehicle?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .padding(.top, 80)
                .multilineTextAlignment(.center)
                .bold()
            
            HStack {
                Text("0")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.distanceCarKm, in: 0...800)
                Text("A lot")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
            Text(String(format: "%.1f km (%.1f mi)", userStart.distanceCarKm, userStart.distanceCarKm * 0.621371))
                            .font(Constants.mainfont)
                            .padding(.top, 10)
        }
    }
}

#Preview {
    Private_Transport_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
