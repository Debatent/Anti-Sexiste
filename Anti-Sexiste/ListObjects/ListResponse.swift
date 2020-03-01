//
//  ListResponse.swift
//  Anti-Sexiste
//
//  Created by user165109 on 28/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation
import SwiftUI


class ListResponse : ObservableObject,Identifiable, Codable{
    @Published var listResponse : [TextResponse]
    
    enum CodingKeys: String, CodingKey {
        case listResponse
    }
    
    required init(from decoder: Decoder) throws {
        print(decoder)
        print("ListResponse")
            do {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                self.listResponse = try values.decode([TextResponse].self, forKey: .listResponse)
            } catch {print(error)
                fatalError("cant decode")}
        }

    
    func encode(to encoder: Encoder) throws {
        
    }

    init(listResponse : [TextResponse]){
        self.listResponse = listResponse
    }
    
    convenience init() {
        self.init(listResponse : [TextResponse()])
    }
}
