//
//  ListPlace.swift
//  Anti-Sexiste
//
//  Created by user165109 on 02/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class ListPlace : Identifiable{
    var places : [Place]
    
    init(){
        self.places = getPlaces()
    }
}
