//
//  TypeResponse.swift
//  Anti-Sexiste
//
//  Created by etud on 04/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class TypeResponse:Identifiable,Codable{
    var name : String
    
    init(typeResponse : String){
        self.name = typeResponse
    }
    
    convenience init(){
        self.init(typeResponse : "")
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
