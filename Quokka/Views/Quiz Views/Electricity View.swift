//
//  Electricity View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 3/14/25.
//

import SwiftUI

struct Electricity_View: View {
    @Binding var userStart: UserData
    var body: some View {
        VStack {
            Text("What is your average monthly electricity bill?")
                .font(Constants.mainfont)
                .padding(.bottom, 80)
                .multilineTextAlignment(.center)
                .bold()
            TextField("$ Amount", value: $userStart.annualElectricityKWh, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding(30)
            
        }
    }
}

#Preview {
    Electricity_View(userStart: Binding.constant(UserData(id: "default", data: ["hello": "poop"])))
}
