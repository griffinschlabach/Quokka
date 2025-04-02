//
//  Recycling View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/14/25.
//

import SwiftUI

struct Recycling_View: View {
    @Binding var userStart: UserData
    var body: some View {
        VStack {
            Text("What percent of your waste do you recycle?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
            .bold()
            HStack {
                Text("0")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.recyclePercentage, in: 0...365)
                Text("100")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
        }
    }
}

#Preview {
    Recycling_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
