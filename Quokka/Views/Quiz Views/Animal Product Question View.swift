//
//  Animal Product Question View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/13/25.
//

import SwiftUI

struct Animal_Product_Question_View: View {
    @Binding var userStart: UserData
    // if let user = decodedUser
    var body: some View {
        VStack{
            Text("How often do you eat the following animal based products?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
                .bold()
            //Pork
            Text("Pork")
                .font(Constants.mainfont)
            HStack {
                Text("Never")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.porkKg, in: 0...365)
                Text("Very Often")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
            // Beef/lamb
            Text("Beef/lamb")
                .font(Constants.mainfont)
            HStack {
                Text("Never")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.beefLambKg, in: 0...365)
                Text("Very Often")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
            // Poultry
            Text("Poultry")
                .font(Constants.mainfont)
            HStack {
                Text("Never")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.poultryKg, in: 0...365)
                Text("Very Often")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
            // Fish/shellfish
            Text("Fish/shellfish")
                .font(Constants.mainfont)
            HStack {
                Text("Never")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.fishKg, in: 0...365)
                Text("Very Often")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
            // Eggs
            Text("Eggs")
                .font(Constants.mainfont)
            HStack {
                Text("Never")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.eggsKg, in: 0...365)
                Text("Very Often")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
            // Cheese
            Text("Cheese")
                .font(Constants.mainfont)
            HStack {
                Text("Never")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.cheeseKg, in: 0...365)
                Text("Very Often")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
            // Milk/yogurt
            Text("Milk/yogurt")
                .font(Constants.mainfont)
            HStack {
                Text("Never")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 2)
                    .scaleEffect(0.75)
                Slider(value: $userStart.dairyKg, in: 0...365)
                Text("Very Often")
                    .font(Constants.mainfont)
                    .padding(.horizontal, 1.5)
                    .scaleEffect(0.75)
            }
        }
    }
}

#Preview {
    Animal_Product_Question_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
