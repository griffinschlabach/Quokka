//
//  Land Grid View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 4/1/25.
//

import SwiftUI

struct Land_Grid_View: View {
    
    @State private var scaleValue: Double = 1
    @Binding var decodedUserData:UserData?

        var body: some View {
            VStack {
                DynamicLandGrid(scaleValue: $scaleValue)
                    .padding()

                Slider(value: $scaleValue, in: 1...40)
                    .padding()
            }
            .onAppear(perform: {
                scaleValue = decodedUserData?.totalLandUsage ?? 1.0
            })
        }
}

#Preview {
    Land_Grid_View(decodedUserData: Binding.constant(UserData(data: ["name" : ""])))
}
