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
        case listResponse = "comments"
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
        try container.encode(listResponse, forKey: .listResponse)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encode(reaction, forKey: .reaction)
        try container.encode(report, forKey: Post.CodingKeys.report)
    }
    
    
    init(id : String){
        guard let url = URL(string: "http://vps799211.ovh.net/posts/"+id) else {fatalError("url false")}
        var request = URLRequest(url : url)
        request.httpMethod = "GET"
        self.location = ""
        self._id = ""
        self.message = ""
        self.title = ""
        self.createdAt = ""
        self.listResponse = []
        self.author = nil
        self.reaction = 0
        self.report = 0
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {print(response!)

                return
            }
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
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
                    self.listResponse = post.listResponse
                    self.author = post.author
                    self.reaction = post.reaction
                    self.report = post.report
                } catch {print(error)
                    fatalError("cant decode")}
            }
            
            
            
        }.resume()
        
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
        self.init(placePost : "",idPost : nil, listResponse : [], message : "", title : "", date : "", user : nil)
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
    
    
    func savePost(){
        let session = URLSession.shared
        let url = URL(string: "http://vps799211.ovh.net/posts")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let data = try JSONEncoder().encode(self)
            print(data as NSData)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            let task = session.uploadTask(with: request, from: data){data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {print(response!)
                        
                    return
                }
                print(httpResponse)
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let content = data else {
                    print("No data")
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        let post : Post = try JSONDecoder().decode(Post.self, from: content)
                        self._id = post._id
                        self.createdAt = post.createdAt
                    } catch {print(error)
                        fatalError("cant decode")}
                }

            }
            task.resume()
        } catch {print(error)
            fatalError("cant encode")}

    }
    
}

