//
//  TextPost.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation
import SwiftUI


class TextPost :Identifiable, PostProtocol{
    var idPost: Int
    	
    var responses: ListResponse
    	
    var message: String
    
    var title: String
    
    var date: Date
    
    required init(from decoder: Decoder) throws{
        
    }
}
