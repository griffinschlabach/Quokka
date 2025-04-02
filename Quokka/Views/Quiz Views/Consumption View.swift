//
//  Consumption View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/14/25.
//

import SwiftUI

struct Consumption_View: View {
    @Binding var userStart: UserData
    var body: some View {
        VStack {
            Text("In a year, how much do you spend on the following items?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
                .bold()
            
            //Clothing
            Text("Clothing")
                .font(Constants.mainfont)
            TextField("$ Amount", value: $userStart.clothingSpent, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(30)
            
            //Electronics
            Text("Electronics")
                .font(Constants.mainfont)
            TextField("$ Amount", value: $userStart.electronicsSpent, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(.horizontal, 30)
            
            // Other products
            Text("Other non-food consumer products (e.g. home goods, personal care items, books)")
                .font(Constants.mainfont)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 15)
                .padding(.top, 30)
            TextField("$ Amount", value: $userStart.otherGoodsSpent, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(.horizontal, 30)
        }
        
    }
}

#Preview {
    Consumption_View(userStart: Binding.constant(UserData(data: ["hello": "poop"])))
}
