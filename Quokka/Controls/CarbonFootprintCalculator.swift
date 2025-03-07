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
        
    ]
    // Computed properites for each category
    
    //    var dietFootprint: Double {
    //        let emissions = (beefLambKg * 27) + (porkKg * 12) + (poultryKg * 6) +
    //                        (fishKg * 5) + (eggsKg * 4.5) + (cheeseKg * 13.5) + (dairyKg * 3.2)
    //        return emissions
    //    }
    //
    //    var foodTransportFootprint: Double {
    //        let importedFoodFactor = (100 - percentLocalFood) / 100
    //        let estimatedFoodKg = beefLambKg + porkKg + poultryKg + fishKg + eggsKg + cheeseKg + dairyKg
    //        return estimatedFoodKg * importedFoodFactor * (2.5 - 0.2)
    //    }
    //
    //    var wasteFootprint: Double {
    //        let yearlyWaste = wasteKgPerWeek * 52
    //        let baseEmission = yearlyWaste * 2.52
    //        let adjustedEmission = baseEmission * (1 - (0.5 * recyclePercentage / 100))
    //        return adjustedEmission
    //    }
    //
    //    var shoppingFootprint: Double {
    //        let clothingEmissions = clothingSpent * 50
    //        let electronicsEmissions = electronicsSpent * 100
    //        let otherGoodsEmissions = otherGoodsSpent * 70
    //        return clothingEmissions + electronicsEmissions + otherGoodsEmissions
    //    }
    //
    //    var electricityFootprint: Double {
    //        let adjustedElectricity = (1 - renewableEnergyPercentage / 100)
    //        return annualElectricityKWh * 0.92 * adjustedElectricity
    //    }
    //
    //    var housingFootprint: Double {
    //        return baseHousingEmissions / Double(householdSize)
    //    }
    //
    //    var carFootprint: Double {
    //        let adjustedCarTravel = distanceCarKm * carEmissionFactor * (1 - carpoolPercentage / 100)
    //        return adjustedCarTravel
    //    }
    //
    //    var publicTransportFootprint: Double {
    //        return (distanceBusKm * 0.09) + (distanceTrainKm * 0.04)
    //    }
    //
    //    var flightFootprint: Double {
    //        return (shortFlightHours * 255) + (longFlightHours * 150)
    //    }
    //
    //    // TOTAL CARBON FOOTPRINT CALCULATION
    //
    //    var totalFootprint: Double {
    //        return dietFootprint +
    //               foodTransportFootprint +
    //               wasteFootprint +
    //               shoppingFootprint +
    //               electricityFootprint +
    //               housingFootprint +
    //               carFootprint +
    //               publicTransportFootprint +
    //               flightFootprint
    //    }
    //
    //    var totalLandUsage: Double {
    //        return ((totalFootprint)/1000.0) * 0.0073  // in km^2
    //    }
    //
    //    var totalEarths: Double {
    //        return totalLandUsage/510100000.0
    //    }
}

