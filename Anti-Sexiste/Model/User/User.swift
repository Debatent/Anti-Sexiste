//
//  User.swift
//  Anti-Sexiste
//
//  Created by user165109 on 09/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class User: Codable, ObservableObject{
    @Published var pseudo : String
    @Published var password : String
    @Published var postsMarked : [String]
    
    
    enum CodingKeys: String, CodingKey {
        case pseudo
        case password
        case postsMarked
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.pseudo = try values.decode(String.self, forKey: .pseudo)
                self.password = try values.decode(String.self, forKey: .password)
                self.postsMarked = try values.decode([String].self, forKey: .postsMarked)

            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pseudo, forKey: .pseudo)
        try container.encode(password, forKey: .password)
    }
    
    init(pseudo : String, password : String){
        self.pseudo = pseudo
        self.password = password
        self.postsMarked = []
    }
    convenience init(){
        self.init(pseudo : "", password : "")
    }
}
