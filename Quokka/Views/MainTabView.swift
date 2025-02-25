//
//  MainTabView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct MainTabView: View {
    
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
            MainProfileView()
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("Profile")
                }
            
        }
    }
}

#Preview {
    MainTabView()
}
