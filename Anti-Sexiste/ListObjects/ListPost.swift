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
        let data : Data
        guard let file = Bundle.main.url(forResource: "data", withExtension: "json")
            else {fatalError("Cant load file")}
    

        do {
            data = try Data(contentsOf: file)
        }catch {fatalError("cant open content")}
        
        do {
            
            let decoder = JSONDecoder()
            
            self.listPost = try decoder.decode([Post].self,from:data)
        } catch {print(error)
            fatalError("cant decode")}
    }
    
    init(listPost: [Post]) {
        self.listPost = listPost
    }
    
    
    func addPost(post: Post){
        self.listPost.append(post)
    }
  

}
