//
//  NewItemViewViewModel.swift
//  Quokka
//
//  Created by Lucille Thoen (student LM) on 3/7/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewViewModel: ObservableObject {
   
    @Published var title = ""
    @Published var showAlert = false
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else  {
            return false
        }
        return true
    }
    
}
