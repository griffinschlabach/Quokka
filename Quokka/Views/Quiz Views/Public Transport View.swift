//
//  Public Transport View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/24/25.
//

import SwiftUI

struct Public_Transport_View: View {
    @Binding var userStart: UserData
    var body: some View {
        Text("On a weekly basis, how far do you travel on the following public transports?")
            .font(Constants.mainfont)
            .padding(.bottom, 80)
            .multilineTextAlignment(.center)
            .bold()
        
        Text("Bus")
            .font(Constants.mainfont)
        HStack {
            Text("0")
                .font(Constants.mainfont)
                .padding(.horizontal, 2)
                .scaleEffect(0.75)
            Slider(value: $userStart.distanceBusKm, in: 0...800)
            Text("A lot")
                .font(Constants.mainfont)
                .padding(.horizontal, 1.5)
                .scaleEffect(0.75)
        }
        Text(String(format: "%.1f km (%.1f mi)", userStart.distanceBusKm, userStart.distanceBusKm * 0.621371))
                        .font(Constants.mainfont)
                        .padding(.top, 10)
        
        Text("Train")
            .font(Constants.mainfont)
            .padding(.top, 60)
        HStack {
            Text("0")
                .font(Constants.mainfont)
                .padding(.horizontal, 2)
                .scaleEffect(0.75)
            Slider(value: $userStart.distanceTrainKm, in: 0...800)
            Text("A lot")
                .font(Constants.mainfont)
                .padding(.horizontal, 1.5)
                .scaleEffect(0.75)
        }
        Text(String(format: "%.1f km (%.1f mi)", userStart.distanceTrainKm, userStart.distanceTrainKm * 0.621371))
                        .font(Constants.mainfont)
                        .padding(.top, 10)
    }
}

#Preview {
    Public_Transport_View(userStart: Binding.constant(UserData(id: "default", data: ["hello": "poop"])))
}
