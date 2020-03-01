//
//  ListPost.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation
import SwiftUI



class ListPost : ObservableObject,Identifiable{
    @Published var listPost : [Post]
    
    init(listPost: [Post]) {
        self.listPost = listPost
    }
    enum CodingKeys: String, CodingKey {
        case listPost = "posts"
    }
    

    
    func getListPost() -> [Post]{
        return self.listPost
    }
}
