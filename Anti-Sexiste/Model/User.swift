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
    @Published var email : String
    @Published var password : String
    @Published var postReaction : [String]
    @Published var commentReaction : [String]
    @Published var postReported : [String]
    @Published var commentReported : [String]
    private var _id : String?
    var token : String = ""
    
    enum CodingKeys: String, CodingKey {
        case pseudo
        case password
        case postReaction
        case email
        case postReported
        case commentReaction
        case commentReported
        case _id
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.pseudo = try values.decode(String.self, forKey: .pseudo)
            self.email = try values.decode(String.self, forKey: .email)
            self.password = ""
            self.postReaction = try values.decode([String].self, forKey: .postReaction)
            self.postReported = []
            self.commentReaction = try values.decode([String].self, forKey: .commentReaction)
            self.commentReported = []
            self._id = try values.decode(String.self, forKey: ._id)
            
            
        } catch {print(error)
            fatalError("cant decode")}
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pseudo, forKey: .pseudo)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
    
    init(pseudo : String, email : String ,password : String){
        self.pseudo = pseudo
        self.password = password
        self.postReaction = []
        self.postReported = []
        self.commentReported = []
        self.commentReaction = []
        self.email = email
        self._id = nil
    }
    convenience init(){
        self.init(pseudo : "", email : "" ,password : "")
    }
    
}
