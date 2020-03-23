//
//  Response.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class Response: Identifiable, Codable, ObservableObject{
    
    var _id: String?
    
    var message: String
    
    var createdAt: String
    
    var type: String
    
    @Published var author : String?

    
    enum CodingKeys: String, CodingKey {
        case _id
        case message
        case createdAt
        case type
        case author
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self._id = try values.decodeIfPresent(String.self, forKey: ._id)
                self.message = try values.decode(String.self, forKey: .message)
                self.createdAt = try values.decode(String.self, forKey: .createdAt)
                self.type = try values.decode(String.self, forKey: .type)
                self.author = try values.decodeIfPresent(String.self, forKey: .author)

            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(_id, forKey: ._id)
        try container.encode(message, forKey: .message)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(author, forKey: .author)
    }
    
    
    init(idResponse : String?, message : String, date : String, typeResponse : String, user : String?){
        self._id = idResponse
        self.message = message
        self.createdAt = date
        self.type = typeResponse
        self.author = user
    }
    convenience init() {
        self.init(idResponse : nil, message : "", date : "", typeResponse : "", user : nil)
    }
}
