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
        self.types = getTypeResponse()
    }
}
