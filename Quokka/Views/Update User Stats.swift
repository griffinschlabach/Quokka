//
//  Update User Stats.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/25/25.
//

import SwiftUI

struct Update_User_Stats: View {
    // State variables for controlling DisclosureGroup expansion and content values
    @State private var isTransportationExpanded = false
    @State private var isHousingExpanded = false
    @State private var isElectricityExpanded = false
    @Binding var userStart: UserData
    @State var isGasCar: Bool = false
    @State var isElectricCar: Bool = false
    @State var isMotorcycle: Bool = false
    @State var isFreeStandNoWater: Bool = false
    @State var isFreeStandWater: Bool = false
    @State var isApartment: Bool = false
    @State var isDuplex: Bool = false
    @State var isCondo: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                
                // Transportation category with a slider and toggles
                DisclosureGroup("Transportation", isExpanded: $isTransportationExpanded) {
                    VStack {
                        Text("Update your common mode of transportation")
                            .font(Constants.mainfont)
                            .padding(.bottom, 20)
                            .bold()
                        
                        Toggle("Car (gasoline)", isOn: $isGasCar)
                            .font(Constants.mainfont)
                            .padding(10)
                            .onChange(of: isGasCar) { newValue in
                                if newValue {
                                    userStart.carEmissionFactor = 0.21
                                    isElectricCar = false
                                    isMotorcycle = false
                                }
                            }
                        
                        Toggle("Car (electric/hybrid)", isOn: $isElectricCar)
                            .font(Constants.mainfont)
                            .padding(10)
                            .onChange(of: isElectricCar) { newValue in
                                if newValue {
                                    userStart.carEmissionFactor = 0.06
                                    isGasCar = false
                                    isMotorcycle = false
                                }
                            }
                        
                        Toggle("Motorcyle", isOn: $isMotorcycle)
                            .font(Constants.mainfont)
                            .padding(10)
                            .onChange(of: isMotorcycle) { newValue in
                                if newValue {
                                    userStart.baseHousingEmissions = 0.1
                                    isGasCar = false
                                    isElectricCar = false
                                }
                            }
                        Text("How many hours a year do you spend on short-haul flights (<3 hours)?")
                            .font(Constants.mainfont)
                            .padding(.bottom, 20)
                            .bold()
                        HStack {
                            Text("0")
                                .font(Constants.mainfont)
                                .padding(.horizontal, 2)
                                .scaleEffect(0.75)
                            Slider(value: $userStart.shortFlightHours, in: 0...200)
                            Text("200")
                                .font(Constants.mainfont)
                                .padding(.horizontal, 1.5)
                                .scaleEffect(0.75)
                        }
                        Text(String(format: "%0.0f hours", userStart.shortFlightHours))
                                        .font(Constants.mainfont)
                                        .padding(.top, 10)
                        
                        Text("How many hours a year do you spend on long-haul flights?")
                            .font(Constants.mainfont)
                            .padding(.bottom, 20)
                            .padding(.top, 20)
                            .bold()
                        HStack {
                            Text("0")
                                .font(Constants.mainfont)
                                .padding(.horizontal, 2)
                                .scaleEffect(0.75)
                            Slider(value: $userStart.longFlightHours, in: 0...200)
                            Text("200")
                                .font(Constants.mainfont)
                                .padding(.horizontal, 1.5)
                                .scaleEffect(0.75)
                        }
                             Text(String(format: "%0.0f hours", userStart.longFlightHours))
                                        .font(Constants.mainfont)
                                        .padding(.top, 10)
                    }
                    .padding()
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                
                // Animal Products category with additional controls
                DisclosureGroup("Housing", isExpanded: $isHousingExpanded) {
                    VStack{
                        Text("What is your housing type?")
                            .font(Constants.mainfont)
                            .padding(.bottom, 20)
                            .bold()
                        
                        Toggle("Freestanding house (no running water)", isOn: $isFreeStandNoWater)
                            .font(Constants.mainfont)
                            .padding(10)
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
                            .padding(10)
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
                            .padding(10)
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
                            .padding(10)
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
                            .padding(10)
                            .onChange(of: isCondo) { newValue in
                                if newValue {
                                    userStart.baseHousingEmissions = 6000
                                    isFreeStandNoWater = false
                                    isFreeStandWater = false
                                    isApartment = false
                                    isDuplex = false
                                }
                            }
                        Text("How many others live in your household?")
                            .font(Constants.mainfont)
                            .padding(.bottom, 20)
                            .bold()
                        
                        HStack {
                            Text("0")
                                .font(Constants.mainfont)
                                .padding(.horizontal, 2)
                                .scaleEffect(0.75)
                            Slider(value: $userStart.householdSize, in: 0...10)
                            Text("10+")
                                .font(Constants.mainfont)
                                .padding(.horizontal, 1.5)
                                .scaleEffect(0.75)
                        }
                    }
                    .padding()
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                
                DisclosureGroup("Electricity", isExpanded: $isElectricityExpanded){
                    VStack {
                        Text("What is your average monthly electricity bill?")
                            .font(Constants.mainfont)
                            .bold()
                        TextField("$ Amount", value: $userStart.annualElectricityKWh, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .padding(30)
                        
                    }
                    .padding()
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                

            }
            .padding()
        }
    }
}

#Preview {
    Update_User_Stats(userStart: Binding.constant(UserData(id: "default", data: ["hello": "poop"])))
}
