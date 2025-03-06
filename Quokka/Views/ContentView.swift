//
//  ContentView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    //user we look at
    @State var decodedUserData: UserData?
    //displays action
    @State var statusMessage: String = "No Action Taken Yet"
    //user id we look at
    @State var savedUserUUID: String?
    
    
    var body: some View {
        
        MainTabView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID:$savedUserUUID)
        
        
    }
}

#Preview {
    ContentView()
    
}
