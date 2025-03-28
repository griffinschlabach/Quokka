//
//  ChecklistItem.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 3/24/25.
//

import Foundation

struct ChecklistItem : Identifiable{
    
    var id:String
    var name:String
    var isChecked:Bool
    var timesChecked:Int
    
    init(name: String = "default", isChecked: Bool = false, timesChecked: Int = 999) {
        self.id = UUID().uuidString
        self.name = name
        self.isChecked = isChecked
        self.timesChecked = timesChecked
    }
    
    mutating func toggleChecked() {
        isChecked.toggle()
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "isChecked": isChecked,
            "timesChecked": timesChecked
        ]
    }
    
    static func fromDictionary(_ dictionary: [String: Any]) -> ChecklistItem? {
        guard let id = dictionary["id"] as? String,
              let name = dictionary["name"] as? String,
              let isChecked = dictionary["isChecked"] as? Bool,
              let timesChecked = dictionary["timesChecked"] as? Int else {
            return nil
        }
        
        var item = ChecklistItem(name: name, isChecked: isChecked, timesChecked: timesChecked)
        item.id = id // Preserve the original ID
        return item
    }
}

