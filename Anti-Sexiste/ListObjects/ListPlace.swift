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
        let data : Data = loadDATA(file: "place")
        do {
            self.places = try JSONDecoder().decode([Place].self,from:data)
        } catch {print(error)
            fatalError("cant decode")}
    }
}
