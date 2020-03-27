//
//  Place.swift
//  Anti-Sexiste
//
//  Created by etud on 04/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class Place:Identifiable,Codable{
    var name : String
    
    init(place : String){
        self.name = place
    }
    enum CodingKeys: String, CodingKey {
        case name
        
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.name = try values.decode(String.self, forKey: .name)


            } catch {print(error)
                fatalError("cant decode")}
        }
}
