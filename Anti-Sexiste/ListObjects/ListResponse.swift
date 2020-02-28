//
//  ListResponse.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation
import SwiftUI



class ListResponse : ObservableObject,Identifiable{
    @Published var listResponse : [ResponseProtocol]
    
    init(listResponse : [ResponseProtocol]){
        self.listResponse = listResponse
    }
}
