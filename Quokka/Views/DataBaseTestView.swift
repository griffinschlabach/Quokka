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
    let id: String
    let name: String
    let email: String
    let porkKg,fishKg, eggsKg, cheeseKg, dairyKg, percentLocalFood, wasteKgPerWeek, recyclePercentage,
    clothingSpent, electronicsSpent, otherGoodsSpent, annualElectricityKWh,renewableEnergyPercentage,
    baseHousingEmissinos, householdSize, distanceCarmKm, carEmissionFactor, carpoolPercentage, distanceBusKm, distanceTrainKm, shortFlightHouse, longFlightHours : Double
    
    
    // Decode from Firebase dictionary
    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? "Unknown User"
        self.email = data["email"] as? String ?? "Unkown User"
        self.porkKg = data["porkKg"] as? Double ?? 1.0
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
        self.baseHousingEmissinos = data["baseHousingEmissinos"] as? Double ?? 1.0
        self.householdSize = data["householdSize"] as? Double ?? 1.0
        self.distanceCarmKm = data["distanceCarmKm"] as? Double ?? 1.0
        self.carEmissionFactor = data["carEmissionFactor"] as? Double ?? 1.0
        self.carpoolPercentage = data["carpoolPercentage"] as? Double ?? 1.0
        self.distanceBusKm = data["distanceBusKm"] as? Double ?? 1.0
        self.distanceTrainKm = data["distanceTrainKm"] as? Double ?? 1.0
        self.shortFlightHouse = data["shortFlightHouse"] as? Double ?? 1.0
        self.longFlightHours = data["longFlightHours"] as? Double ?? 1.0
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
        
        let chickens = 5.0
        let cows = 6.0
        
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
}

// Preview provider
#Preview {
    DataBaseTestView(decodedUserData: Binding.constant(UserData(id: "", data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
