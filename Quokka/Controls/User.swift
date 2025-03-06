//
//  User.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/28/25.
//

//UserID Firebase G8dnqDw6Cae6t9XTGmkv

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


class User: ObservableObject{
    @Published var email: String
    @Published var password: String
    @Published var isAuthenticated: Bool = false
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
    
    func encode() -> [String: Any]{
        let data : [String: Any] = [
            "firstName": firstName,
            "lastName": lastName
        ]
        return data
    }
    
    func decode(data: [String: Any]?) {
        
        guard let d = data else {return}
        
        if let firstName = d["firstName"] as? String{
            self.firstName = firstName
        }
        
        if let lastName = d["lastName"] as? String{
            self.lastName = lastName
        }
    }
}
