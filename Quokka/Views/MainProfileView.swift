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
        Text(statusMessage)
            .font(Constants.mainfont)
        
        
    }
    
}

#Preview {
    MainProfileView(decodedUserData: Binding.constant(UserData(id: "", data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
