//
//  ChecklistView.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/25/25.
//

import SwiftUI

struct ChecklistView: View {
    
    @Binding var item: ChecklistItem
    
    var body: some View {
        
        HStack {
            Text(item.name)
            Spacer()
            Button(action: {
                item.isChecked.toggle()
            }) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
                    .font(.system(size: 22))
            }
            
        }
    }
}

#Preview {
    ChecklistView(item: Binding.constant(ChecklistItem()))
}
