//
//  ListTypeResponse.swift
//  Anti-Sexiste
//
//  Created by etud on 04/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class ListTypeResponse : Identifiable{
    var types : [TypeResponse]
    
    init(){
        self.types = []
        
        guard let url = URL(string: "http://vps799211.ovh.net/labels/comments") else {fatalError("url false")}
        var request = URLRequest(url : url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {print(response!)

                return
            }
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            

                do {
                    self.types = try JSONDecoder().decode([TypeResponse].self,from: content)
                } catch {print(error)
                    fatalError("cant decode")}
                
            
            
            
        }.resume()
    }
}
