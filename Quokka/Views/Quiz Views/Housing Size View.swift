//
//  Housing Size View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/19/25.
//

import SwiftUI

struct Housing_Size_View: View {
    @Binding var userStart: UserData
    var body: some View {
        VStack {
            Text("How many others live in your household?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
                .bold()
            
            HStack {
                Text("0")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.householdSize, in: 0...10)
                Text("10+")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
        }
    }
}

#Preview {
    Housing_Size_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
