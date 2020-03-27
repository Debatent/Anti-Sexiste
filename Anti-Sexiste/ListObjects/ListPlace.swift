//
//  ListPlace.swift
//  Anti-Sexiste
//
//  Created by user165109 on 02/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation


class ListPlace : ObservableObject,Identifiable{
    @Published var places : [Place]
    
    init(){
        self.places = []
        
        guard let url = URL(string: "http://vps799211.ovh.net/labels/posts") else {fatalError("url false")}
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
                    self.places = try JSONDecoder().decode([Place].self,from: content)
                    print(self.places)
                } catch {print(error)
                    fatalError("cant decode")}
            
            
            
            
        }.resume()
    }
}


func filterResponse(listResponse : [Response], typeResponse : String)->[Response]{
    if (typeResponse != "Tout"){
        return  listResponse.filter { $0.type == typeResponse }
    }
    else{
        return listResponse    }
}
