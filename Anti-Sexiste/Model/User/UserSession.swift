//
//  UserSession.swift
//  Anti-Sexiste
//
//  Created by etud on 10/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class UserSession:ObservableObject{
    @Published var isConnected : Bool
    @Published var user : User?
    
    init(user : User?){
        self.user = user
        if (user != nil){
            self.isConnected = true
        }
        else {
            self.isConnected = false
        }
    }
    
    func setUser(user : User?){
        if let user = user{
            self.isConnected = true
            self.user = user
        }
        else {
            self.isConnected = false
            self.user = nil
        }
    }
    
    
}

enum UserSessionError: Error {
    case notConnected
}
