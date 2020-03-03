//
//  DataJson.swift
//  Anti-Sexiste
//
//  Created by user165109 on 02/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation



func load() -> Data{
    let data : Data
        guard let file = Bundle.main.url(forResource: "data", withExtension: "json")
            else {fatalError("Cant load file")}
    

        do {
            data = try Data(contentsOf: file)
        }catch {fatalError("cant open content")}
    
    return data
}
