//
//  Place.swift
//  Anti-Sexiste
//
//  Created by etud on 04/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class Place:Identifiable,Codable{
    var place : String
    var icon : String
    
    init(place : String, icon : String){
        self.place = place
        self.icon = icon
    }
}
