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
        self.listPost = getListPost()
            
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
            return self.listPost.filter { $0.placePost == place }
        }
        else{
            return self.listPost
        }
    }
    
    
}
