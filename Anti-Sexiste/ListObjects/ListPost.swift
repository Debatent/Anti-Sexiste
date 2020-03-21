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
    
    init(){
        self.listPost = []
        
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
            do {
                self.listPost = try JSONDecoder().decode([Post].self,from: content)
                print(self.listPost)
            } catch {print(error)
                fatalError("cant decode")}
            
            
        }.resume()
        print(self.listPost)
        }
    
    init(listPost: [Post]) {
        self.listPost = listPost
    }
    
    
    func addPost(post: Post){
        self.listPost.append(post)
    }
    
    func deletePost(post : Post){
        if let index = self.listPost.firstIndex(where: {$0 === post}) {
          self.listPost.remove(at: index)
        }
    }
    
    func filterList(place : String)-> [Post]{
        if (place != "Tout"){
            return self.listPost.filter { $0.location == place }
        }
        else{
            return self.listPost
        }
    }
    
    
}
