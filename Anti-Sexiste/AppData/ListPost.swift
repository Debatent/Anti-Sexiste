//
//  ListPost.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation
import Combine



class ListPost : ObservableObject,Identifiable{
    @Published var listPost : [Post]
    
    
    init(listPost: [Post]) {
        self.listPost = listPost
    }
    
    init(){
        self.listPost = []
        self.reloadPosts()
    }
    
    func reloadPosts(){
        guard let url = URL(string: "http://vps799211.ovh.net/posts") else {fatalError("url false")}
        var request = URLRequest(url : url)
        request.httpMethod = "GET"
        
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
                    self.listPost = try JSONDecoder().decode([Post].self,from: content)
                } catch {print(error)
                    fatalError("cant decode")}
            }
                
            
            
            
            
        }.resume()
    }
    
    
    func addPost(post: Post, user : User?){
        guard let data = try? JSONEncoder().encode(post) else {
                fatalError("Cant load file")
            }
        
            
            if let url = URL(string: "http://vps799211.ovh.net/posts") {
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                if let user = user {
                
                    request.setValue(user.token, forHTTPHeaderField: "auth-token")
                }
                

                request.httpMethod = "POST"
                request.httpBody = data
                
                URLSession.shared.dataTask(with: request){data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                            (200...299).contains(httpResponse.statusCode) else {print(response!)
                                
                            return
                        }
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
                                self.listPost.append(post)
                            } catch {print(error)
                                fatalError("cant decode")}
                        }

                    }.resume()
                }
        }
        
    
    
    func deletePost(post : Post, user : User){
        if let index = self.listPost.firstIndex(where: {$0._id! == post._id!}) {
            
            let body = [ "idPost" : post._id!]
            let finalBody = try! JSONSerialization.data(withJSONObject: body)
            if let url = URL(string: "http://vps799211.ovh.net/posts/"+post._id!) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            
            request.setValue(user.token, forHTTPHeaderField: "auth-token")
            

            request.httpMethod = "DELETE"
            request.httpBody = finalBody
            
            URLSession.shared.dataTask(with: request){data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {print(response!)
                            
                        return
                    }
                    if let error = error {
                        print(error.localizedDescription)
                    }

                    

                }.resume()
            }
            self.listPost.remove(at: index)
        }
    }
    
 
    
    
}



func filterList(listPost : [Post],place : String)-> [Post]{
    if (place != "Tout"){
        return listPost.filter { $0.location == place }
    }
    else{
        return listPost
    }
}
