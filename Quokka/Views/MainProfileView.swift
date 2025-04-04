//
//  MainProfileView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI
import FirebaseDatabase

struct MainProfileView: View {
    
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
    @State var uuidField: String = ""
    
    var body: some View {
        
        if let user = decodedUserData {
            VStack(alignment: .leading, spacing: 10) {
                Text("Name: \(user.name)")
                    .font(.headline)
                Text("Email: \(user.email)")
                    .font(.subheadline)
                Text("Long Flight Hours: \(user.longFlightHours)")
                Text("Diet Footprint: \(String(format: "%.2f", user.dietFootprint))")
                Text("Default Checklist Item name: \(user.itemList[0].name)")
                Text("Default Checklist Item checked: \(user.itemList[0].isChecked)")
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        else {
            VStack {
                HStack{
                    Text("Login Manually: ")
                    TextField("UUID", text: $uuidField)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .padding(30)
                        .onSubmit {
                            Task {
                                await getUserFromFirebase(id:uuidField)
                                savedUserUUID = uuidField
                            }
                        }
                }
                .padding(.horizontal, 10)
                QuizView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID: $savedUserUUID)
            }
        }
        
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
    


#Preview {
    MainProfileView(decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""),
        uuidField:"")
}
