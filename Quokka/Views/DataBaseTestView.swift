//
//  DataBaseTestView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 3/6/25.
//

import SwiftUI
import FirebaseDatabase

// all data associated with each user
struct UserData: Identifiable {
    var id: String
    var name: String
    var email: String
    var porkKg, beefLambKg, poultryKg, fishKg, eggsKg, cheeseKg, dairyKg, percentLocalFood, wasteKgPerWeek, recyclePercentage,
        clothingSpent, electronicsSpent, otherGoodsSpent, annualElectricityKWh,renewableEnergyPercentage,
        baseHousingEmissions, householdSize, distanceCarKm, carEmissionFactor, carpoolPercentage, distanceBusKm, distanceTrainKm, shortFlightHours, longFlightHours : Double
    
    
    // Decode from Firebase dictionary
    init(id: String, data: [String: Any]) {
        self.id = id
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
}

//view displayed in TabView as TEST TEST
struct DataBaseTestView: View {
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Test Database")
                .font(.title)
                .padding()
            
            Button(action: {
                let calculator = CarbonFootprintCalculator()
                writeUserToFirebase(extraUserData:calculator.data)
            }) {
                Text("Write User to Firebase")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            //if savedUserUUID == nil, this button will not retrieve any data
            Button(action: {
                Task {
                    await readUserFromFirebase()
                }
            }) {
                Text("Read Event from Firebase")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(savedUserUUID == nil)
            
            Button(action: {
                            Task {
                                await getUserFromFirebase(id:"A15E56B5-6CAA-4CB2-91B4-F5F9D207F1A7")
                            }
                        }) {
                            Text("Get User from Firebase")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

            
            // Displays
            if let user = decodedUserData {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Event ID: \(user.id)")
                        .font(.subheadline)
                    Text("Name: \(user.name)")
                        .font(.headline)
                    Text("Email: \(user.email)")
                        .font(.subheadline)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            } else {
                Text(statusMessage)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
    }
    
    //adds user to database
    public func writeUserToFirebase(extraUserData :[String:Any]) {
        let userUUID = UUID().uuidString // Generate UUID
        let usersRef = Database.database().reference().child("users")
        let userRef = usersRef.child(userUUID) //name of position in the database
     
        //manually input desired data in dictionary form to be uploaded
        let userDataOne: [String: Any] = [
            "name": "Lucy",
            "email": "lucy@gmail.com"
        ]
        let userData = userDataOne.merging(extraUserData) { (current, new) in new }
        
        
        
        //creates value at the position
        userRef.setValue(userData) { (error, _) in
            if let error = error {
                statusMessage = "Failed to write: \(error.localizedDescription)"
            } else { //if there's no error it saves the UUID
                savedUserUUID = userUUID //saves the id upon creation of the user for later use
                statusMessage = "Wrote user with UUID: \(userUUID)"
            }
        }
    }
    
    //TODO - add an id parameter so we can access the userdata without instant creation
    public func readUserFromFirebase() async {
        
        //checks for a saved id
        guard let uuid = savedUserUUID else {
            statusMessage = "No user UUID saved to read"
            decodedUserData = nil
            return //ends early if no id
        }
        
        //checks for specific id
        guard let data = try? await Database.database().reference().child("users/\(uuid)").getData() else {
            statusMessage = "Failed to fetch user data"
            decodedUserData = nil
            return //ends early if fails
        }
        
        //checks for presence of ANY data in correct form in position
        guard let dictionary = data.value as? [String: Any] else {
            statusMessage = "Failed to cast user data to dictionary"
            decodedUserData = nil
            return //ends early if fails
        }
        
        //if search succeeds past all previous checks
        let user = UserData(id: uuid, data: dictionary)
        decodedUserData = user //retreives userdata and saves it to a state varaible
        statusMessage = "Successfully read event"
    }
    
    public func getUserFromFirebase(id:String?) async {
            //checks for a saved id
            guard let uuid = id else {
                statusMessage = "No user UUID saved to read"
                decodedUserData = nil
                return //ends early if no id
            }
            
            //checks for specific id
            guard let data = try? await Database.database().reference().child("users/\(uuid)").getData() else {
                statusMessage = "Failed to fetch user data"
                decodedUserData = nil
                return //ends early if fails
            }
            
            //checks for presence of ANY data in correct form in position
            guard let dictionary = data.value as? [String: Any] else {
                statusMessage = "Failed to cast user data to dictionary"
                decodedUserData = nil
                return //ends early if fails
            }
            
            //if search succeeds past all previous checks
            let user = UserData(id: uuid, data: dictionary)
            decodedUserData = user //retreives userdata and saves it to a state varaible
            statusMessage = "Successfully found event"
        }

}

// Preview provider
#Preview {
    DataBaseTestView(decodedUserData: Binding.constant(UserData(id: "", data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
