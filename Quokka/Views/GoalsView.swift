//
//  GoalsView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//
import SwiftUI
struct GoalsView: View {
    
    
    
    var daisyGoal = 50.0
    var sunflowerGoal = 100.0
    var wildflowerGoal = 200.0
    var forestGoal = 500.0
    
    var currentStatus = 20.0
    
    var body: some View {
        
        VStack {
           
            Text("Daisies")
                .font(Constants.mainfont)
            
            ZStack {
                Rectangle()
                    .frame(width: 375, height: 50)
                    .foregroundColor(Color.c_light_green)
                    .cornerRadius(7)
                HStack {
                    UnevenRoundedRectangle(topLeadingRadius: 7, bottomLeadingRadius: 7, bottomTrailingRadius: 0, topTrailingRadius: 0)
                        .frame(width: CGFloat(375.0*(currentStatus/daisyGoal)), height: 50)
                        .cornerRadius(0)
                        .padding(.leading, 9)
                        .foregroundColor(Color.c_dark_green)
                   Spacer()
                }
                //Spacer()
            }
            
            Text("Sunflowers")
                .font(Constants.mainfont)
            
            ZStack {
                Rectangle()
                    //.stroke(Color.c_light_green, lineWidth: 9)
                    .frame(width: 375, height: 50)
                    .foregroundColor(Color.c_light_green)
                    .cornerRadius(7)
                HStack {
                    UnevenRoundedRectangle(topLeadingRadius: 7, bottomLeadingRadius: 7, bottomTrailingRadius: 0, topTrailingRadius: 0)
                        .frame(width: CGFloat(375.0*(currentStatus/sunflowerGoal)), height: 50)
                        .cornerRadius(0)
                        .padding(.leading, 9)
                        .foregroundColor(Color.c_dark_green)
                    Spacer()
                }
            }
            
            Text("Wildflower field")
                .font(Constants.mainfont)
            
            ZStack {
                Rectangle()
                    //.stroke(Color.c_light_green, lineWidth: 9)
                    .frame(width: 375, height: 50)
                    .foregroundColor(Color.c_light_green)
                    .cornerRadius(7)
                HStack {
                    UnevenRoundedRectangle(topLeadingRadius: 7, bottomLeadingRadius: 7, bottomTrailingRadius: 0, topTrailingRadius: 0)
                        .frame(width: CGFloat(375.0*(currentStatus/wildflowerGoal)), height: 50)
                        .cornerRadius(0)
                        .padding(.leading, 9)
                        .foregroundColor(Color.c_dark_green)
                    Spacer()
                }
            }
            
            Text("Forest")
                .font(Constants.mainfont)
            
            ZStack {
                Rectangle()
                    //.stroke(Color.c_light_green, lineWidth: 9)
                    .frame(width: 375, height: 50)
                    .foregroundColor(Color.c_light_green)
                    .cornerRadius(7)
                HStack {
                    UnevenRoundedRectangle(topLeadingRadius: 7, bottomLeadingRadius: 7, bottomTrailingRadius: 0, topTrailingRadius: 0)
                        .frame(width: CGFloat(375.0*(currentStatus/forestGoal)), height: 50)
                        .cornerRadius(0)
                        .padding(.leading, 9)
                        .foregroundColor(Color.c_dark_green)
                    Spacer()
                }
            }
           
        }
        
    }
}
#Preview {
    GoalsView()
}

