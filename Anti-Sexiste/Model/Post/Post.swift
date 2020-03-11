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
    
    var placePost: String
    
    var idPost: Int?
    	
    @Published var listResponse: [Response]
    
    var message: String
    
    var title: String
    
    var date: String
    
    @Published var user : User?
    
    @Published var mark : Int

    enum CodingKeys: String, CodingKey {
        case placePost
        case idPost
        case listResponse
        case message
        case title
        case date
        case user
        case mark
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.placePost = try values.decode(String.self, forKey: .placePost)
                self.idPost = try values.decodeIfPresent(Int.self, forKey: .idPost)
                self.message = try values.decode(String.self, forKey: .message)
                self.title = try values.decode(String.self, forKey: .title)
                self.date = try values.decode(String.self, forKey: .date)
                self.listResponse = try values.decode([Response].self, forKey: .listResponse)
                self.user = try values.decodeIfPresent(User.self, forKey: .user)
                self.mark = try values.decode(Int.self, forKey: .mark)


            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(placePost, forKey: .placePost)
        try container.encodeIfPresent(idPost, forKey: .idPost)
        try container.encode(message, forKey: .message)
        try container.encode(title, forKey: .title)
        try container.encode(date, forKey: .date)
        try container.encode(listResponse, forKey: .listResponse)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encode(mark, forKey: .mark)
    }
    
    init(placePost : String,idPost : Int?,listResponse : [Response], message : String, title : String, date : String, user: User?){
        self.placePost = placePost
        self.idPost = idPost
        self.listResponse = listResponse
        self.message = message
        self.title = title
        self.date = date
        self.mark = 0
    }
    
    convenience init() {
        self.init(placePost : "",idPost : nil, listResponse : [], message : "", title : "", date : "", user : nil)
    }
    
    //// POur le moment, ne fonctionnera pas sur un post qui vient d'être crée (pas d'ID)
    func increment(user : User){
        if (!user.postsMarked.contains(self.idPost!)){
            user.postsMarked.append(self.idPost!)
            self.mark += 1
        }
    }
    
}

