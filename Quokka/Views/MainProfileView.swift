//
//  MainProfileView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct MainProfileView: View {
    
    
    var body: some View {
        
        
        if false {
            VStack(alignment: .leading, spacing: 10) {
//                Text("Event ID: \(user.id)")
//                    .font(.subheadline)
//                Text("Name: \(user.name)")
//                    .font(.headline)
//                Text("Email: \(user.email)")
//                    .font(.subheadline)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        } else {
            Text("Awesome Profile View!")
                .font(.body)
                .foregroundColor(.gray)
        }
        
        
    }
    
}

#Preview {
    MainProfileView()
}
