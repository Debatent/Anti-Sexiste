//
//  JsonDATA.swift
//  Anti-Sexiste
//
//  Created by etud on 04/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


func loadDATA(file : String) -> Data {
    let data : Data
        guard let file = Bundle.main.url(forResource: file, withExtension: "json")
            else {fatalError("Cant load file")}
    

        do {
            data = try Data(contentsOf: file)
        }
        catch {fatalError("cant open content")}
    return data
}
