//
//  Quiz Navigation View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/25/25.
//

import SwiftUI

struct QuizView: View {
    // Track the current page index
    @State private var currentPage = 0
    @State var userStart: UserData = UserData(data: ["hello": "poop"])
    //user we look at
    @Binding var decodedUserData: UserData?
    //displays action
    @Binding var statusMessage: String
    //user id we look at
    @Binding var savedUserUUID: String?

    // Computed property for individual quiz views
    var quizPages: [AnyView] {
        [
            AnyView(Animal_Product_Question_View(userStart: $userStart)),
            AnyView(Food_Locality_View(userStart: $userStart)),
            AnyView(Waste_Production_View(userStart: $userStart)),
            AnyView(Consumption_View(userStart: $userStart)),
            AnyView(Recycling_View(userStart: $userStart)),
            AnyView(Electricity_View(userStart: $userStart)),
            AnyView(Housing_View(userStart: $userStart)),
            AnyView(Housing_Size_View(userStart: $userStart)),
            AnyView(Private_Transport_View(userStart: $userStart)),
            AnyView(Public_Transport_View(userStart: $userStart)),
            AnyView(Carpool_View(userStart: $userStart)),
            AnyView(Air_Travel_View(userStart: $userStart)),
            AnyView(SaveView(userStart: $userStart, decodedUserData: $decodedUserData, statusMessage: $statusMessage, savedUserUUID: $savedUserUUID))
        ]
    }

    var body: some View {
        VStack {
            // The TabView displays each quiz page
            TabView(selection: $currentPage) {
                ForEach(0..<quizPages.count, id: \.self) { index in
                    quizPages[index]
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPage)
            
            // Navigation arrows
            HStack {
                Button(action: {
                    if currentPage > 0 {
                        currentPage -= 1
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                }
                //.padding()

                Spacer()

                Button(action: {
                    if currentPage < quizPages.count - 1 {
                        currentPage += 1
                    }
                }) {
                    Image(systemName: "arrow.right")
                        .font(.title)
                }
                //.padding()
            }
            .padding(.horizontal)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(decodedUserData: Binding.constant(UserData(data: ["name" : ""])), statusMessage: Binding.constant(""), savedUserUUID: Binding.constant(""))
    }
}


