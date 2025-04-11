//
//  Animal Product Daily Quiz View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 4/11/25.
//

import SwiftUI

struct Animal_Product_Daily_Quiz_View: View {
    @Binding var userStart: UserData
    
    // Local state variables for daily consumption (units per day)
    @State private var dailyPork: Double = 0
    @State private var dailyBeef: Double = 0
    @State private var dailyPoultry: Double = 0
    @State private var dailyFish: Double = 0
    @State private var dailyEggs: Double = 0
    @State private var dailyCheese: Double = 0
    @State private var dailyDairy: Double = 0

    var body: some View {
        VStack {
            Text("How often did you eat the following animal-based products today?")
                .font(Constants.mainfont)
                .padding(.bottom, 20)
                .multilineTextAlignment(.center)
                .bold()
            
            // For each animal product, create a slider for today's consumption.
            Group {
                Text("Pork")
                    .font(Constants.mainfont)
                Slider(value: $dailyPork, in: 0...((userStart.porkKg / 365.0) * 2))
                Text(String(format: "%.0f units", dailyPork))
                
                Text("Beef/Lamb")
                    .font(Constants.mainfont)
                Slider(value: $dailyBeef, in: 0...((userStart.beefLambKg / 365.0) * 2))
                Text(String(format: "%.0f units", dailyBeef))
                
                Text("Poultry")
                    .font(Constants.mainfont)
                Slider(value: $dailyPoultry, in: 0...((userStart.poultryKg / 365.0) * 2))
                Text(String(format: "%.0f units", dailyPoultry))
                
                Text("Fish/Shellfish")
                    .font(Constants.mainfont)
                Slider(value: $dailyFish, in: 0...((userStart.fishKg / 365.0) * 2))
                Text(String(format: "%.0f units", dailyFish))
                
                Text("Eggs")
                    .font(Constants.mainfont)
                Slider(value: $dailyEggs, in: 0...((userStart.eggsKg / 365.0) * 2))
                Text(String(format: "%.0f units", dailyEggs))
                
                Text("Cheese")
                    .font(Constants.mainfont)
                Slider(value: $dailyCheese, in: 0...((userStart.cheeseKg / 365.0) * 2))
                Text(String(format: "%.0f units", dailyCheese))
                
                Text("Milk/Yogurt")
                    .font(Constants.mainfont)
                Slider(value: $dailyDairy, in: 0...((userStart.dairyKg / 365.0) * 2))
                Text(String(format: "%.0f units", dailyDairy))
            }
            .padding(.vertical, 5)
            
            // Submit Button: calculates today's land saved (in hectares) and updates userStart.landSaved.
            Button(action: {
                let calculator = AnimalProductLandCalculator(
                    baselinePorkYearly: userStart.porkKg,
                    baselineBeefYearly: userStart.beefLambKg,
                    baselinePoultryYearly: userStart.poultryKg,
                    baselineFishYearly: userStart.fishKg,
                    baselineEggsYearly: userStart.eggsKg,
                    baselineCheeseYearly: userStart.cheeseKg,
                    baselineDairyYearly: userStart.dairyKg,
                    dailyPork: dailyPork,
                    dailyBeef: dailyBeef,
                    dailyPoultry: dailyPoultry,
                    dailyFish: dailyFish,
                    dailyEggs: dailyEggs,
                    dailyCheese: dailyCheese,
                    dailyDairy: dailyDairy)
                
                let dailyLandSaved = calculator.dailyLandSavedHectares()
                // Update the cumulative land saved value (in hectares)
                userStart.landSaved += dailyLandSaved
                print("Today's land saved: \(dailyLandSaved) hectares")
                print("Total cumulative land saved: \(userStart.landSaved) hectares")
            }) {
                Text("Submit")
                    .font(Constants.mainfont)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    // Sample UserData with baseline values for yearly consumption and an initial landSaved value of 0.
    Animal_Product_Question_View(userStart: Binding.constant(UserData(data: [
        "id": "user123",
        "uuid": "uuid123",
        "name": "Test User",
        "email": "test@example.com",
        "porkKg": 365.0,
        "beefLambKg": 365.0,
        "poultryKg": 365.0,
        "fishKg": 365.0,
        "eggsKg": 365.0,
        "cheeseKg": 365.0,
        "dairyKg": 365.0,
        "percentLocalFood": 50.0,
        "wasteKgPerWeek": 10.0,
        "recyclePercentage": 40.0,
        "clothingSpent": 500.0,
        "electronicsSpent": 1000.0,
        "otherGoodsSpent": 800.0,
        "annualElectricityKWh": 5000.0,
        "renewableEnergyPercentage": 20.0,
        "baseHousingEmissions": 4500.0,
        "householdSize": 4.0,
        "distanceCarKm": 15000.0,
        "carEmissionFactor": 0.21,
        "carpoolPercentage": 10.0,
        "distanceBusKm": 500.0,
        "distanceTrainKm": 1000.0,
        "shortFlightHouse": 10.0,
        "longFlightHours": 20.0,
        "landSaved": 0.0,
        "itemList": [:]
    ])))
}
