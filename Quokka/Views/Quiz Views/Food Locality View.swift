//
//  Food Locality View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/13/25.
//

import SwiftUI

struct Food_Locality_View: View {
    @Binding var userStart: UserData
    var body: some View {
        VStack {
            Text("How much of the food do you eat is unprocessed, unpackaged, or locally grown?")
                .font(Constants.mainfont)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 80)
            HStack {
                Text("0")
                    .font(Constants.mainfont)
                    .scaleEffect(0.75)
                    .padding(.horizontal, 5)
                Slider(value: $userStart.percentLocalFood, in: 0...365)
                Text("100")
                    .font(Constants.mainfont)
                    .scaleEffect(0.75)
                    .padding(.horizontal, 5)
            }
        }
        
    }
}

#Preview {
    Food_Locality_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
