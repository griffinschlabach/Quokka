//
//  ContentView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(Constants.mainfont)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
