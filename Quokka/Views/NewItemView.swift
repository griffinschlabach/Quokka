//
//  NewItemView.swift
//  Quokka
//
//  Created by Lucille Thoen (student LM) on 3/6/25.
//

import SwiftUI

struct NewItemView: View {
    
    @Binding var newItemPresented: Bool
    @StateObject var viewModel = NewItemViewViewModel()
    
    var body: some View {
        VStack {
            Text("New item")
                .font(.system(size: 32))
                .bold()
            
            Form {
                TextField("Item Name", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Button(action: {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }, label: {
                    Text("Save")
                }) .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Please fill in all fields")
                    )
                }
            }
        }
        
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
