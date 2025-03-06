//
//  ContentView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: User
    
    var body: some View {
        
        DataBaseTestView()
        
        
    }
}

#Preview {
    ContentView()
        .environmentObject(User())
    
}
