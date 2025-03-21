//
//  MainTabView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var viewModel = MainTabViewViewModel()
    
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
    @State private var items = [
        Item(name: "go vegan", isCompleted: false),
        Item(name: "reduce carbon footprint", isCompleted: false),
        Item(name: "take public transport", isCompleted: false)]
    
    var body: some View {
        
        
        TabView {
            
            //goals
            NavigationView {
                GoalsView()
                    .navigationTitle("Goals")
                    .toolbar {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .tabItem {
                Image(systemName:"person.circle.fill")
                Text("Goals")
                
            }
            
            //checklist
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
                Text("Checklist")
            }
            
            //profile
            MainProfileView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID: $savedUserUUID)
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("Profile")
                }
            
            //test
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
