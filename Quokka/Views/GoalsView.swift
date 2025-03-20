//
//  GoalsView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct GoalsView: View {
    
    @State var goalTitle: String = "goal"
    
    var goal = 100.0
    var currentStatus = 20.0
    
    var body: some View {
        
        VStack {
//            Text("Goals")
//                .font(.system(size: 50))
//                .font(Constants.mainfont)
//                .padding()
            
            //Spacer()
            
            Text(goalTitle)
            
            ZStack {
                Rectangle()
                    .stroke(Color.black, lineWidth: 9)
                    .frame(width: 375, height: 50)
                    .cornerRadius(7)
                HStack {
                    Rectangle().frame(width: CGFloat(375.0*(currentStatus/goal)), height: 50)
                        .cornerRadius(7)
                        .padding(.leading, 13)
                    Spacer()
                }
                
            }
            //Spacer()
        }
        
    }
}

#Preview {
    GoalsView()
}
