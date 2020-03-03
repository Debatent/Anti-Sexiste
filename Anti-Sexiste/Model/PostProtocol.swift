//
//  PostProtocol.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


protocol PostProtocol{
    var idPost : Int {get}
    var placePost : String {get}
    var listResponse : [Response]{get set}
    var message : String {get}
    var title : String {get}
    var date : String {get}
    
}
