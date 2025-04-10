//
//  CarbonFootprintCalculator.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 2/25/25.
//

import Foundation

struct CarbonFootprintCalculator {
    
    var data:[String : Double] = [
        
        // Diet & food consumption
        "beefLambKg" : 160.0,
        "porkKg": 30.0,
        "poultryKg": 200.0,
        "fishKg": 100.0,
        "eggsKg": 90.0,
        "cheeseKg": 100.0,
        "dairyKg": 300.0,
        "percentLocalFood": 0.1,  // 0-100%
        //
        //    // Waste & consumption
        "wasteKgPerWeek": 9.0,
        "recyclePercentage": 0.90,  // 0-100%
        "clothingSpent": 1300.0,
        "electronicsSpent": 400.0,
        "otherGoodsSpent": 1000.0,
        //
        //    // Electricity & housing
        "annualElectricityKWh": 400.0,
        "renewableEnergyPercentage": 0.1, // 0-100%
        "baseHousingEmissions": 9000.0,  // Based on housing type
        "householdSize": 1500.0,
        //
        //    // Transportation
        "distanceCarKm": 5200.0,
        "carEmissionFactor": 0.21,  // 0.21 for gas, 0.06 for electric
        "carpoolPercentage": 0.2,  // 0-100%
        "distanceBusKm": 300.0,
        "distanceTrainKm": 30.0,
        "shortFlightHours": 10.0,
        "longFlightHours": 20.0,
        
        "landSaved":10.0
        
    ]
    
}

