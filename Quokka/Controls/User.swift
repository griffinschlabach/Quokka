//
//  User.swift
//  Quokka
//
//  Created by Griffin Schlabach (student LM) on 2/28/25.
//

import Foundation
import SwiftUI

class User : ObservableObject {
    
    @Published var email:String
    @Published var password:String
    @Published var isUserAuthenticated:Bool = false
    
    init(email: String = "" , password: String = "") {
        self.email = email
        self.password = password
    }
    
}
