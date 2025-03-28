//
//  DataBaseTestView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 3/6/25.
//

import SwiftUI
import FirebaseDatabase


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
            Button(action: {
                addItemToUser(userID: savedUserUUID ?? "No ID", data: ChecklistItem(name:"eat_more_garbage"))
            }) {
                Text("Add Item to User itemList")
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
                Text("Spit User from Firebase")
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
                    await getUserFromFirebase(id:"C957D23E-8F18-4280-A44E-F4246D2AD33A")
                    savedUserUUID = "C957D23E-8F18-4280-A44E-F4246D2AD33A"
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
                    Text("Event ID: \(user.uuid)")
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
        var userDataOne: [String: Any] = [
            "uuid" : "\(userUUID)",
            "name": "Lucy",
            "email": "lucy@gmail.com",
        ]
        var userData = userDataOne.merging(extraUserData) { (current, new) in new }
        
        
        
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
    
    public func addItemToUser(userID:String, data:ChecklistItem) {
        let itemsRef = Database.database().reference().child("users/\(userID)").child("itemList")
        let itemRef = itemsRef.child(data.name) //name of position in the database
     
        //converts checklist item properties to String:Any Form
        
        var formatted = data.toDictionary()
        
        //creates value at the position
        itemRef.setValue(formatted) { (error, _) in
            if let error = error {
                statusMessage = "Failed to write: \(error.localizedDescription)"
            }
        }
    }
    
    //TODO - add an id parameter so we can access the userdata without instant creation
    public func readUserFromFirebase() async {
        
        //checks for a saved id
        guard let uuID = savedUserUUID else {
            statusMessage = "No user UUID saved to read"
            decodedUserData = nil
            return //ends early if no id
        }
        
        //checks for specific id
        guard let data = try? await Database.database().reference().child("users/\(uuID)").getData() else {
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
        let user = UserData(data: dictionary)
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
        let user = UserData(data: dictionary)
        decodedUserData = user //retreives userdata and saves it to a state varaible
        statusMessage = "Successfully found event"
    }
}

// Preview provider
#Preview {
    DataBaseTestView(decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
