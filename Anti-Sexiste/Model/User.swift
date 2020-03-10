//
//  User.swift
//  Anti-Sexiste
//
//  Created by user165109 on 09/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class User: Codable, ObservableObject{
    @Published var email : String
    @Published var password : String
    
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.email = try values.decode(String.self, forKey: .email)
                self.password = try values.decode(String.self, forKey: .password)
                

            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        
    }
    
    init(email : String, password : String){
        self.email = email
        self.password = password
    }
    convenience init(){
        self.init(email : "", password : "")
    }
}
