//
//  Waste Production View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/13/25.
//

import SwiftUI

struct Waste_Production_View: View {
    @Binding var userStart: UserData
    var body: some View {
        VStack {
            Text("How many large trash bags (~30 gallon) of waste do you produce each week")
                .font(Constants.mainfont)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 80)
            HStack {
                Text("0 bags")
                    .font(Constants.mainfont)
                    .scaleEffect(0.75)
                    .padding(.horizontal, 5)
                Slider(value: $userStart.wasteKgPerWeek, in: 0...120) //large trash bag roughly 12 lbs
                Text("10 bags")
                    .font(Constants.mainfont)
                    .scaleEffect(0.75)
                    .padding(.horizontal, 5)
            }
        }
    }
}

#Preview {
    Waste_Production_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
