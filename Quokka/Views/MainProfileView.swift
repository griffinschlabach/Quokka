//
//  MainProfileView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct MainProfileView: View {
    
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
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
            QuizView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID: $savedUserUUID)
        }
        
    }
    
}

#Preview {
    MainProfileView(decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
