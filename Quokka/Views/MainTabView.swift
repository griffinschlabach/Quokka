//
//  MainTabView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct MainTabView: View {
    
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
    
    var body: some View {
        TabView {
            GoalsView()
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("Goals")
                }
            ChecklistView()
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("Daily")
                }
            MainProfileView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID:$savedUserUUID)
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("Profile")
                }
            DataBaseTestView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID:$savedUserUUID)
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("TEST TEST")
                }
            
        }
    }
}

#Preview {
    MainTabView(decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
