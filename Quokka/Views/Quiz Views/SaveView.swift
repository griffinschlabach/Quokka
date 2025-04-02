//
//  SaveView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 4/1/25.
//

import SwiftUI
import FirebaseDatabase

struct SaveView: View {
    
    @Binding var userStart: UserData
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
    var body: some View {
       
        Button(action: {
            Task {
                writeUserToFirebase(extraUserData: userStart.toDictionary())
                addItemToUser(userID: savedUserUUID ?? "", data: ChecklistItem(name:"poop"))
            }
        }) {
            Text("SAVE USER")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
    }
    
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
    
    
    
    
}

#Preview {
    SaveView(userStart: Binding.constant(UserData(data: ["hello": "poop"])), decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
