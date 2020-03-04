//
//  ResponseProtocol.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


protocol ResponseProtocol{
    var idResponse : Int {get}
    var message : String {get}
    var date : String {get}
    var typeResponse : String {get}
}
