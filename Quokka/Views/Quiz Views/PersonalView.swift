//
//  PersonalView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 4/8/25.
//

import SwiftUI
import FirebaseDatabase

struct PersonalView: View {
   
    @Binding var userStart: UserData
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
    @State var name = ""
    @State var email = ""
    @State var uuidField: String = ""
    
    var body: some View {
        
        VStack {
            Text("Make sure to hit enter after typing each response.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Text("")
            
            Text("Demo ID's:")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            Text("Early account:")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .textSelection(.enabled)
                .foregroundColor(.gray)
            Text("47E386D1-645D-4A24-9DA5-192F63BEDF1F")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .textSelection(.enabled)
                .foregroundColor(.gray)
            Text("Late account:")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .textSelection(.enabled)
                .foregroundColor(.gray)
            Text("BFE943DC-8A24-4401-85D5-D2254E96731B")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .textSelection(.enabled)
                .foregroundColor(.gray)
            
                
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
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
                .padding(30)
                .onSubmit {
                    Task {
                        userStart.name = name
                    }
            }
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
                .padding(30)
                .onSubmit {
                    Task {
                        userStart.email = email
                    }
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
    PersonalView(userStart: Binding.constant(UserData(data: ["hello": "poop"])), decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
