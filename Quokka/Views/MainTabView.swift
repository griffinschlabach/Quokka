//
//  MainTabView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var viewModel = MainTabViewViewModel()
    
    @State private var items = [
        Item(name: "go vegan", isCompleted: false),
        Item(name: "reduce carbon footprint", isCompleted: false),
        Item(name: "take public transport", isCompleted: false)]
    
    var body: some View {
        
        
        TabView {
            GoalsView()
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("Goals")
                }
            NavigationView {
                List {
                    ForEach($items, id: \.name) {
                        $item in
                        ChecklistView(item: $item)
                    }
                }
                .navigationTitle("Checklist")
                .toolbar {
                    Button(action: {
                        viewModel.showingNewItemView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                .sheet(isPresented: $viewModel.showingNewItemView, content: {
                    NewItemView(newItemPresented: $viewModel.showingNewItemView )
                })
            }
        
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
