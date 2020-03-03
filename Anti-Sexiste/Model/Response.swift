//
//  Response.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class Response: Identifiable, Codable{
    
    var idResponse: Int
    
    var message: String
    
    var date: String
    
    var typeResponse: String
    
    

    
    
    init(idResponse : Int, message : String, date : String, typeResponse : String){
        self.idResponse = idResponse
        self.message = message
        self.date = date
        self.typeResponse = typeResponse
    }
    convenience init() {
        self.init(idResponse : 0, message : "", date : "", typeResponse : "serious")
    }
}
