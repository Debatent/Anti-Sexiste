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

    enum CodingKeys: String, CodingKey {
        case placePost
        case idPost
        case listResponse
        case message
        case title
        case date
        case user
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

            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        
    }
    
    init(placePost : String,idPost : Int?,listResponse : [Response], message : String, title : String, date : String, user: User?){
        self.placePost = placePost
        self.idPost = idPost
        self.listResponse = listResponse
        self.message = message
        self.title = title
        self.date = date
    }
    
    convenience init() {
        self.init(placePost : "",idPost : nil, listResponse : [], message : "", title : "", date : "", user : nil)
    }
    
}

