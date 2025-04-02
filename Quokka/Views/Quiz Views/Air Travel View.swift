//
//  Air Travel View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/24/25.
//

import SwiftUI

struct Air_Travel_View: View {
    @Binding var userStart: UserData
    var body: some View {
        Text("How many hours a year do you spend on short-haul flights (<3 hours)?")
            .font(Constants.mainfont)
            .padding(.bottom, 80)
            .multilineTextAlignment(.center)
            .bold()
        HStack {
            Text("0")
                .font(Constants.mainfont)
                .padding(.horizontal, 2)
                .scaleEffect(0.75)
            Slider(value: $userStart.shortFlightHours, in: 0...200)
            Text("200")
                .font(Constants.mainfont)
                .padding(.horizontal, 1.5)
                .scaleEffect(0.75)
        }
        Text(String(format: "%0.0f hours", userStart.shortFlightHours))
                        .font(Constants.mainfont)
                        .padding(.top, 10)
        
        Text("How many hours a year do you spend on long-haul flights?")
            .font(Constants.mainfont)
            .padding(.bottom, 80)
            .padding(.top, 80)
            .multilineTextAlignment(.center)
            .bold()
        HStack {
            Text("0")
                .font(Constants.mainfont)
                .padding(.horizontal, 2)
                .scaleEffect(0.75)
            Slider(value: $userStart.longFlightHours, in: 0...200)
            Text("200")
                .font(Constants.mainfont)
                .padding(.horizontal, 1.5)
                .scaleEffect(0.75)
        }
             Text(String(format: "%0.0f hours", userStart.longFlightHours))
                        .font(Constants.mainfont)
                        .padding(.top, 10)
    }
}

#Preview {
    Air_Travel_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
