//
//  MainTabView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var viewModel = MainTabViewViewModel()
    @StateObject var checklistViewModel = ChecklistViewModel()
    
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?
    
    //@State var checklistItems: [ChecklistItem] = []
    
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
//            NavigationView {
//                List {
//                    ForEach($checklistViewModel.checklistItems) { $item in
//                        HStack {
//                            ChecklistView(item: $item)
//                            Text("\(item.isChecked)")
//                        }
//                    }
//                }
//                .navigationTitle("Checklist")
//                .toolbar {
//                    Button(action: {
//                        addNewItem()
//                    }, label: {
//                        Image(systemName: "plus")
//                    })
//                    Button(action: {
//                        pullChecklistItems()
//                    }, label: {
//                        Image(systemName: "circle")
//                    })
//                    
//                }
//            }
//            .tabItem {
//                Image(systemName:"person.circle.fill")
//                Text("Checklist")
//            }
            
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
    

    
    // Add a new checklist item
    private func addNewItem() {
        //tbd
    }
    
    // DOESNT WORK YET??
    private func pushChecklistItems() {
        decodedUserData?.itemList = checklistViewModel.checklistItems
        //decodedUserData = checklistViewModel.userData.map {$0}
    }
    
    private func pullChecklistItems() {
        //checklistItems = decodedUserData?.itemList ?? []
        checklistViewModel.checklistItems = decodedUserData?.itemList ?? []
    }
    
}

#Preview {
    MainTabView(decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
}
