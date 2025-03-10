//
//  ChecklistView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct Item {
    var name: String
    var isCompleted: Bool
}

struct ChecklistView: View {
   
    @Binding var item: Item
    
    @State private var items = [
        Item(name: "go vegan", isCompleted: false),
        Item(name: "reduce carbon footprint", isCompleted: false),
        Item(name: "take public transport", isCompleted: false)
    ]
    
    var body: some View {
        
        HStack {
            Text(item.name)
            Spacer()
            Image(systemName:
                    item.isCompleted
                  ? "checkmark.circle.fill" :
                  "circle")
                .foregroundColor(.blue)
                .font(.system(size: 22))
                .onTapGesture {
                    item.isCompleted.toggle()
                }
        }
        
        
//        List {
//            ForEach($items, id: \.name) {
//                $item in
//                GoalsView(item: $item)
//            }
//        }
    }
}

#Preview {
    ChecklistView(item: .constant(Item(name: "reduce carbon footprint", isCompleted: false)))
}
