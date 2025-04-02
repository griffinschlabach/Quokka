//
//  UserData.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 3/24/25.
//

import Foundation

// all data associated with each user
class UserData: ObservableObject, Identifiable {
    var id:String
    var uuid:String
    var name: String
    var email: String
    var porkKg, beefLambKg, poultryKg, fishKg, eggsKg, cheeseKg, dairyKg, percentLocalFood, wasteKgPerWeek, recyclePercentage,
        clothingSpent, electronicsSpent, otherGoodsSpent, annualElectricityKWh,renewableEnergyPercentage,
        baseHousingEmissions, householdSize, distanceCarKm, carEmissionFactor, carpoolPercentage, distanceBusKm, distanceTrainKm, shortFlightHours, longFlightHours : Double
    @Published var itemList:[ChecklistItem]
    
    
    // Decode from Firebase dictionary
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? "NO ID"
        self.uuid = data["uuid"] as? String ?? "No UUID"
        self.name = data["name"] as? String ?? "Unknown User"
        self.email = data["email"] as? String ?? "Unkown User"
        self.porkKg = data["porkKg"] as? Double ?? 1.0
        self.beefLambKg = data["beefLambKg"] as? Double ?? 1.0
        self.poultryKg = data["poultryKg"] as? Double ?? 1.0
        self.fishKg = data["fishKg"] as? Double ?? 1.0
        self.eggsKg = data["eggsKg"] as? Double ?? 1.0
        self.cheeseKg = data["cheeseKg"] as? Double ?? 1.0
        self.dairyKg = data["dairyKg"] as? Double ?? 1.0
        self.percentLocalFood = data["percentLocalFood"] as? Double ?? 1.0
        self.wasteKgPerWeek = data["wasteKgPerWeek"] as? Double ?? 1.0
        self.recyclePercentage = data["recyclePercentage"] as? Double ?? 1.0
        self.clothingSpent = data["clothingSpent"] as? Double ?? 1.0
        self.electronicsSpent = data["electronicsSpent"] as? Double ?? 1.0
        self.otherGoodsSpent = data["otherGoodsSpent"] as? Double ?? 1.0
        self.annualElectricityKWh = data["annualElectricityKWh"] as? Double ?? 1.0
        self.renewableEnergyPercentage = data["renewableEnergyPercentage"] as? Double ?? 1.0
        self.baseHousingEmissions = data["baseHousingEmissions"] as? Double ?? 1.0
        self.householdSize = data["householdSize"] as? Double ?? 1.0
        self.distanceCarKm = data["distanceCarKm"] as? Double ?? 1.0
        self.carEmissionFactor = data["carEmissionFactor"] as? Double ?? 1.0
        self.carpoolPercentage = data["carpoolPercentage"] as? Double ?? 1.0
        self.distanceBusKm = data["distanceBusKm"] as? Double ?? 1.0
        self.distanceTrainKm = data["distanceTrainKm"] as? Double ?? 1.0
        self.shortFlightHours = data["shortFlightHouse"] as? Double ?? 1.0
        self.longFlightHours = data["longFlightHours"] as? Double ?? 1.0
        
        
        self.itemList = []
        if let itemDict = data["itemList"] as? [String: [String: Any]] {
            self.itemList = convertToChecklistItems(from: itemDict)
        }
    }
    
    // Computed properites for each category
    
    var dietFootprint: Double {
        let emissions = (beefLambKg * 27) + (porkKg * 12) + (poultryKg * 6) +
        (fishKg * 5) + (eggsKg * 4.5) + (cheeseKg * 13.5) + (dairyKg * 3.2)
        return emissions
    }
    
    var foodTransportFootprint: Double {
        let importedFoodFactor = (100 - percentLocalFood) / 100
        let estimatedFoodKg = beefLambKg + porkKg + poultryKg + fishKg + eggsKg + cheeseKg + dairyKg
        return estimatedFoodKg * importedFoodFactor * (2.5 - 0.2)
    }
    
    var wasteFootprint: Double {
        let yearlyWaste = wasteKgPerWeek * 52
        let baseEmission = yearlyWaste * 2.52
        let adjustedEmission = baseEmission * (1 - (0.5 * recyclePercentage / 100))
        return adjustedEmission
    }
    
    var shoppingFootprint: Double {
        let clothingEmissions = clothingSpent * 50
        let electronicsEmissions = electronicsSpent * 100
        let otherGoodsEmissions = otherGoodsSpent * 70
        return clothingEmissions + electronicsEmissions + otherGoodsEmissions
    }
    
    var electricityFootprint: Double {
        let adjustedElectricity = (1 - renewableEnergyPercentage / 100)
        return annualElectricityKWh * 0.92 * adjustedElectricity
    }
    
    var housingFootprint: Double {
        return baseHousingEmissions / Double(householdSize)
    }
    
    var carFootprint: Double {
        let adjustedCarTravel = distanceCarKm * carEmissionFactor * (1 - carpoolPercentage / 100)
        return adjustedCarTravel
    }
    
    var publicTransportFootprint: Double {
        return (distanceBusKm * 0.09) + (distanceTrainKm * 0.04)
    }
    
    var flightFootprint: Double {
        return (shortFlightHours * 255) + (longFlightHours * 150)
    }
    
    // TOTAL CARBON FOOTPRINT CALCULATION
    
    var totalFootprint: Double {
        return dietFootprint +
        foodTransportFootprint +
        wasteFootprint +
        shoppingFootprint +
        electricityFootprint +
        housingFootprint +
        carFootprint +
        publicTransportFootprint +
        flightFootprint
    }
    
    var totalLandUsage: Double {
        return ((totalFootprint)/1000.0) * 0.0073  // in km^2
    }
    
    var totalEarths: Double {
        return totalLandUsage/510100000.0
    }
    
    //    func encode() -> [String: Any]{
    //        let data : [String: Any] = [
    //            "firstName": firstName,
    //            "lastName": lastName
    //        ]
    //        return data
    //    }
    //
    //    func decode(data: [String: Any]?) {
    //
    //        guard let d = data else {return}
    //
    //        if let firstName = d["firstName"] as? String{
    //            self.firstName = firstName
    //        }
    //
    //        if let lastName = d["lastName"] as? String{
    //            self.lastName = lastName
    //        }
    //    }
    
    func convertToChecklistItems(from dictionary: [String: [String: Any]]) -> [ChecklistItem] {
        return dictionary.compactMap { (_, value) in
            ChecklistItem.fromDictionary(value)
        }
    }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> ChecklistItem? {
        guard let id = dictionary["id"] as? String,
              let name = dictionary["name"] as? String,
              let isChecked = dictionary["isChecked"] as? Bool,
              let timesChecked = dictionary["timesChecked"] as? Int else {
            return nil
        }
        
        var item = ChecklistItem(name: name, isChecked: isChecked, timesChecked: timesChecked)
        item.id = id // Preserve the original ID
        return item
    }
    
    public func toDictionary() -> [String: Any] {
            return [
                "id": id,
                "uuid": uuid,
                "name": name,
                "email": email,
                "porkKg": porkKg,
                "beefLambKg": beefLambKg,
                "poultryKg": poultryKg,
                "fishKg": fishKg,
                "eggsKg": eggsKg,
                "cheeseKg": cheeseKg,
                "dairyKg": dairyKg,
                "percentLocalFood": percentLocalFood,
                "wasteKgPerWeek": wasteKgPerWeek,
                "recyclePercentage": recyclePercentage,
                "clothingSpent": clothingSpent,
                "electronicsSpent": electronicsSpent,
                "otherGoodsSpent": otherGoodsSpent,
                "annualElectricityKWh": annualElectricityKWh,
                "renewableEnergyPercentage": renewableEnergyPercentage,
                "baseHousingEmissions": baseHousingEmissions,
                "householdSize": householdSize,
                "distanceCarKm": distanceCarKm,
                "carEmissionFactor": carEmissionFactor,
                "carpoolPercentage": carpoolPercentage,
                "distanceBusKm": distanceBusKm,
                "distanceTrainKm": distanceTrainKm,
                "shortFlightHours": shortFlightHours,
                "longFlightHours": longFlightHours,
                "itemList": itemList.reduce(into: [String: Any]()) { result, item in
                    result[item.id] = item.toDictionary()
                }
            ]
        }
    
}
