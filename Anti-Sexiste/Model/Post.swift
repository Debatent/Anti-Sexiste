//
//  TextPost.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class Post :PostProtocol,Identifiable,Codable{
    
    var placePost: String
    
    var idPost: Int
    	
    var listResponse: ListResponse
    	
    var message: String
    
    var title: String
    
    var date: String


    
    init(placePost : String,idPost : Int,listResponse : ListResponse, message : String, title : String, date : String){
        self.placePost = placePost
        self.idPost = idPost
        self.listResponse = listResponse
        self.message = message
        self.title = title
        self.date = date
    }
    convenience init() {
        self.init(placePost : "street",idPost : 0, listResponse : ListResponse(), message : "", title : "", date : "")
    }
    
}

