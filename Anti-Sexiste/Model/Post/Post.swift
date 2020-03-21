//
//  TextPost.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation
import Combine


class Post :Identifiable,Codable, ObservableObject{
    
    var location: String
    
    var _id: String?
    	
    @Published var listResponse: [Response]?
    
    var message: String
    
    var title: String
    
    var createdAt: String
    
    @Published var author : String?
    
    @Published var reaction : Int
    
    @Published var report : Int
    

    enum CodingKeys: String, CodingKey {
        case location
        case _id
        case listResponse
        case message
        case title
        case createdAt
        case author
        case reaction
        case report
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.location = try values.decode(String.self, forKey: .location)
                self._id = try values.decodeIfPresent(String.self, forKey: ._id)
                self.message = try values.decode(String.self, forKey: .message)
                self.title = try values.decode(String.self, forKey: .title)
                self.createdAt = try values.decode(String.self, forKey: .createdAt)
                self.listResponse = try values.decodeIfPresent([Response].self, forKey: .listResponse)
                self.author = try values.decodeIfPresent(String.self, forKey: .author)
                self.reaction = try values.decode(Int.self, forKey: .reaction)
                self.report = try values.decode(Int.self, forKey: .report)
            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(location, forKey: .location)
        try container.encodeIfPresent(_id, forKey: ._id)
        try container.encode(message, forKey: .message)
        try container.encode(title, forKey: .title)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(listResponse, forKey: .listResponse)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encode(reaction, forKey: .reaction)
        try container.encode(report, forKey: Post.CodingKeys.report)
    }
    
    init(placePost : String,idPost : String?,listResponse : [Response]?, message : String, title : String, date : String, user: String?){
        self.location = placePost
        self._id = idPost
        self.listResponse = listResponse
        self.message = message
        self.title = title
        self.createdAt = date
        self.reaction = 0
        self.report = 0
    }
    
    convenience init() {
        self.init(placePost : "",idPost : nil, listResponse : [], message : "eefezeffezzfefze", title : "", date : "", user : nil)
    }
    
    //// POur le moment, ne fonctionnera pas sur un post qui vient d'être crée (pas d'ID)
    func increment(user : User)->Bool{
        if (!user.postsMarked.contains(self._id!)){
            user.postsMarked.append(self._id!)
            self.reaction += 1
            return true
        }
        return false
    }
    
}

