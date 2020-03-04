//
//  ListTypeResponse.swift
//  Anti-Sexiste
//
//  Created by etud on 04/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class ListTypeResponse : Identifiable{
    var types : [TypeResponse]
    
    init(){
        let data : Data = loadDATA(file: "typeResponse")
        do {
            self.types = try JSONDecoder().decode([TypeResponse].self,from:data)
        } catch {print(error)
            fatalError("cant decode")}
    }
    
}
