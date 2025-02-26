////
////  CarbonFootprintCalculator.swift
////  Quokka
////
////  Created by Allison Tan (student LM) on 2/25/25.
////
//
//import Foundation
//
//struct CarbonFootprintCalculator {
//    // Diet & food consumption
//    @Binding var beefLambKg: Double
//    @Binding var porkKg: Double
//    @Binding var poultryKg: Double
//    @Binding var fishKg: Double
//    @Binding var eggsKg: Double
//    @Binding var cheeseKg: Double
//    @Binding var dairyKg: Double
//    @Binding var percentLocalFood: Double  // 0-100%
////
////    // Waste & consumption
//    @Binding var wasteKgPerWeek: Double
//    @Binding var recyclePercentage: Double  // 0-100%
//    @Binding var clothingSpent: Double
//    @Binding var electronicsSpent: Double
//    @Binding var otherGoodsSpent: Double
////
////    // Electricity & housing
//    @Binding var annualElectricityKWh: Double
//    @Binding var renewableEnergyPercentage: Double  // 0-100%
//    @Binding var baseHousingEmissions: Double  // Based on housing type
//    @Binding var householdSize: Int
////
////    // Transportation
//    @Binding var distanceCarKm: Double
//    @Binding var carEmissionFactor: Double  // 0.21 for gas, 0.06 for electric
//    @Binding var carpoolPercentage: Double  // 0-100%
//    @Binding var distanceBusKm: Double
//    @Binding var distanceTrainKm: Double
//    @Binding var shortFlightHours: Double
//    @Binding var longFlightHours: Double
//
//    // Computed properites for each category
//
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
//}
//
