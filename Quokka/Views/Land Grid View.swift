//
//  Land Grid View.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 4/1/25.
//

import SwiftUI

struct Land_Grid_View: View {
    @State private var scaleValue: Double = 1

        var body: some View {
            VStack {
                DynamicLandGrid(scaleValue: $scaleValue)
                    .padding()

                Slider(value: $scaleValue, in: 1...40)
                    .padding()
            }
        }
}

#Preview {
    Land_Grid_View()
}
