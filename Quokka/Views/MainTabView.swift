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
    
    @State var selectedTab = 1
    
    var body: some View {
        
        TabView(selection:$selectedTab) {
            
            //goals
            ZStack {
                Image("c-background-1")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        Text("Goals")
                            .font(Constants.titlefont)
                            .padding(.top, 20)
                            .padding(.leading,20)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    Spacer()
                    GoalsView(decodedUserData:$decodedUserData)
                    Spacer()
                }
                
                
            }.tabItem {
                Image(systemName:"person.circle.fill")
                    .foregroundColor(.black)
                Text("Goals")
                
                
            }.tag(0)
            
            
            //profile
            
            MainProfileView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID: $savedUserUUID)
                .tabItem {
                    Image(systemName:"person.circle.fill")
                    Text("Profile")
                }
                .tag(1)
            
            //test
            //            DataBaseTestView(decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID:$savedUserUUID)
            //                .tabItem {
            //                    Image(systemName:"person.circle.fill")
            //                    Text("TEST TEST")
            //                }
            //                .tag(2)
            
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
