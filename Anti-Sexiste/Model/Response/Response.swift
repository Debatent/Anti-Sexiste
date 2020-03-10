//
//  Response.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class Response: Identifiable, Codable, ObservableObject{
    
    var idResponse: Int?
    
    var message: String
    
    var date: String
    
    var typeResponse: String
    
    @Published var user : User?

    
    enum CodingKeys: String, CodingKey {
        case idResponse
        case message
        case date
        case typeResponse
        case user
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.idResponse = try values.decodeIfPresent(Int.self, forKey: .idResponse)
                self.message = try values.decode(String.self, forKey: .message)
                self.date = try values.decode(String.self, forKey: .date)
                self.typeResponse = try values.decode(String.self, forKey: .typeResponse)
                self.user = try values.decodeIfPresent(User.self, forKey: .user)

            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        
    }
    
    
    init(idResponse : Int?, message : String, date : String, typeResponse : String, user : User?){
        self.idResponse = idResponse
        self.message = message
        self.date = date
        self.typeResponse = typeResponse
        self.user = user
    }
    convenience init() {
        self.init(idResponse : nil, message : "", date : "", typeResponse : "", user : nil)
    }
}
