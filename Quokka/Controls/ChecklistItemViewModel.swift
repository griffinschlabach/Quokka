//
//  ChecklistItemViewModel.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 3/26/25.
//

import Foundation
import Combine

class ChecklistViewModel: ObservableObject {
    
    @Published var checklistItems: [ChecklistItem] = []
    
    func toggleItem(id: String) {
        if let index = checklistItems.firstIndex(where: { $0.id == id }) {
            checklistItems[index].isChecked.toggle()
        }
    }
    
    func loadChecklist(from userData: UserData?) {
        if let items = userData?.itemList {
            self.checklistItems = items
        }
    }
    
    // Update userData and push to Firebase
    func updateChecklist() {
        pushChecklistToFirebase()
    }
    
    func addItem(_ name: String) {
        let newItem = ChecklistItem(name: name, isChecked: false, timesChecked: 0)
        checklistItems.append(newItem)
        updateChecklist()
    }
    
    func removeItem(at index: IndexSet) {
        checklistItems.remove(atOffsets: index)
        updateChecklist()
    }
    
    private func pushChecklistToFirebase() {
        // Implement Firebase update logic here
    }
}

