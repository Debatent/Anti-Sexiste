//
//  PostProtocol.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


protocol PostProtocol:Codable{
    var idPost : Int {get}
    var placePost : String {get}
    var responses : ListResponse{get}
    var message : String {get}
    var title : String {get}
    var date : Date {get}
    
}
