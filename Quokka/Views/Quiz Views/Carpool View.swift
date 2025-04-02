//
//  Carpool View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/24/25.
//

import SwiftUI

struct Carpool_View: View {
    @Binding var userStart: UserData
    var body: some View {
        VStack{
            Text("What percent of the time do you carpool?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
                .bold()
            
            HStack {
                Text("0%")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.carpoolPercentage, in: 0...100)
                Text("100%")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
        }
    }
}

#Preview {
    Carpool_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
