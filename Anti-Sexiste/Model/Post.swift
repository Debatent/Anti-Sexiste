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
    	
    @Published var comments: [Response]?
    
    var message: String
    
    var title: String
    
    var createdAt: String?
    
    @Published var author : String?
    
    @Published var reaction : Int
    
    @Published var report : Int
    
    var updatedAt : String?
    
    var __v : Int?
    
    enum CodingKeys: String, CodingKey {
        case location
        case _id
        case comments
        case message
        case title
        case createdAt
        case author
        case reaction
        case report
        case updatedAt
        case __v
    }
    
    required init(from decoder: Decoder) throws {
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.location = try values.decode(String.self, forKey: .location)
                self._id = try values.decodeIfPresent(String.self, forKey: ._id)
                self.message = try values.decode(String.self, forKey: .message)
                self.title = try values.decode(String.self, forKey: .title)
                self.createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                self.comments = try values.decodeIfPresent([Response].self, forKey: .comments)
                self.author = try values.decodeIfPresent(String.self, forKey: .author)
                self.reaction = try values.decode(Int.self, forKey: .reaction)
                self.report = try values.decode(Int.self, forKey: .report)
                self.updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                self.__v = try values.decodeIfPresent(Int.self, forKey: .__v)

            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(location, forKey: .location)
        try container.encode(message, forKey: .message)
        try container.encode(title, forKey: .title)       
    }
    
    
    init(id : String){
        self.location = ""
        self._id = ""
        self.message = ""
        self.title = ""
        self.createdAt = nil
        self.comments = []
        self.author = nil
        self.reaction = 0
        self.report = 0
        self.updatedAt = nil
        self.__v = nil
        self.reloadPost(id : id)
    }
    
    init(placePost : String,idPost : String?,listResponse : [Response]?, message : String, title : String, date : String?, user: String?){
        self.location = placePost
        self._id = idPost
        self.comments = listResponse
        self.message = message
        self.title = title
        self.createdAt = date
        self.reaction = 0
        self.report = 0
        self.updatedAt = nil
        self.__v = 0
    }
    
    convenience init() {
        self.init(placePost : "",idPost : nil, listResponse : [], message : "", title : "", date : nil, user : nil)
    }
    
    
    func reloadPost(id : String){
        guard let url = URL(string: "https://azur-vo.fr/posts/"+id) else {fatalError("url false")}
        var request = URLRequest(url : url)
        request.httpMethod = "GET"
        self.location = ""
        self._id = ""
        self.message = ""
        self.title = ""
        self.createdAt = nil
        self.comments = []
        self.author = nil
        self.reaction = 0
        self.report = 0
        self.updatedAt = nil
        self.__v = nil
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {print(response!)

                return
            }
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            guard let content = data else {
                print("No data")
                return
            }

            DispatchQueue.main.async {
                do {

                    let post : Post = try JSONDecoder().decode(Post.self, from: content)
                    self.location = post.location
                    self._id = post._id
                    self.message = post.message
                    self.title = post.title
                    self.createdAt = post.createdAt
                    self.comments = post.comments
                    self.author = post.author
                    self.reaction = post.reaction
                    self.report = post.report
                    self.updatedAt = post.updatedAt
                    self.__v = post.__v
                } catch {print(error)
                    fatalError("cant decode")}
            }
            
            
            
        }.resume()
    }
    
    
    
        
        
      
    }
    

