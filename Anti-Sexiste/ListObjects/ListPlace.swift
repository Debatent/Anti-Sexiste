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
        let data : Data
        guard let file = Bundle.main.url(forResource: "place", withExtension: "json")
            else {fatalError("Cant load file")}
    

        do {
            data = try Data(contentsOf: file)
        }catch {fatalError("cant open content")}
        
        do {
            
            let decoder = JSONDecoder()
            
            self.places = try decoder.decode([Place].self,from:data)
            
        } catch {print(error)
            fatalError("cant decode")}
    }
    
}

class Place:Identifiable,Codable{
    var place : String
    var icon : String
    
    init(place : String, icon : String){
        self.place = place
        self.icon = icon
    }
}
