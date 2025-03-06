//
//  DataBaseTestView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 3/6/25.
//

import SwiftUI
import FirebaseDatabase

// Updated Event model without status and superBowl
struct UserData: Identifiable {
    let id: String
    let name: String
    let email: String
    
    // Decode from Firebase dictionary
    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as? String ?? "Unknown User"
        self.email = data["email"] as? String ?? "Unkown User"
    }
}

struct DataBaseTestView: View {
    // State to hold the decoded event and saved UUID
    @State private var decodedUser: UserData?
    @State private var statusMessage: String = ""
    @State private var savedUserUUID: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Firebase Database Examples")
                .font(.title)
                .padding()
            
            Button(action: {
                writeUserToFirebase()
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
            
            // Display decoded event or status
            if let user = decodedUser {
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
    
    // Function to write the simplified event to Firebase
    func writeUserToFirebase() {
        let userUUID = UUID().uuidString // Generate UUID
        let usersRef = Database.database().reference().child("users")
        let userRef = usersRef.child(userUUID)
        
        let userData: [String: Any] = [
            "name": "Lucy",
            "email": "lucy@gmail.com",
        ]
        
        userRef.setValue(userData) { (error, _) in
            if let error = error {
                statusMessage = "Failed to write: \(error.localizedDescription)"
            } else {
                savedUserUUID = userUUID // Save the UUID
                statusMessage = "Wrote user with UUID: \(userUUID)"
            }
        }
    }
    
    // Async function to read and decode the event from Firebase
    func readUserFromFirebase() async {
        guard let uuid = savedUserUUID else {
            statusMessage = "No user UUID saved to read"
            decodedUser = nil
            return
        }
        
        guard let data = try? await Database.database().reference().child("users/\(uuid)").getData() else {
            statusMessage = "Failed to fetch user data"
            decodedUser = nil
            return
        }
        
        guard let dictionary = data.value as? [String: Any] else {
            statusMessage = "Failed to cast user data to dictionary"
            decodedUser = nil
            return
        }
        
        let user = UserData(id: uuid, data: dictionary)
        decodedUser = user
        statusMessage = "Successfully read event"
    }
}

// Preview provider
#Preview {
    DataBaseTestView()
}
