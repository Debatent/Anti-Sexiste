//
//  JsonDATA.swift
//  Anti-Sexiste
//
//  Created by etud on 04/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//



//if let url = URL(string: "http://vps799211.ovh.net/") {
//   URLSession.shared.dataTask(with: url) { data, response, error in
//if let data = data {
////...
//       }
//   }.resume()
//}



import Foundation




let server =  ProcessInfo.processInfo.environment["Server"];//get environmental variable of the server

private func loadDATA(file : String, type:String = "json") -> Data {
    let data : Data
    guard let file = Bundle.main.url(forResource: file, withExtension: type)
        else {fatalError("Cant load file")}
    
    
    do {
        data = try Data(contentsOf: file)
    }
    catch {fatalError("cant open content")}
    return data
}

//returnType must be of a type reference
private func decodeJsonData <T>(returnType: T.Type ,data: Data) -> T where T:Decodable{
    do {
        return try JSONDecoder().decode(returnType,from: data);
    } catch {print(error)
        fatalError("cant decode")}
}



func getListPost() -> [Post]{
    let data : Data = loadDATA(file: "data")
    return decodeJsonData(returnType: [Post].self, data: data)
}

func getPlaces() -> [Place]{
    let data : Data = loadDATA(file: "place")
    return decodeJsonData(returnType: [Place].self, data: data)
}

func getTypeResponse()-> [TypeResponse]{
    let data : Data = loadDATA(file: "typeResponse")
    return decodeJsonData(returnType: [TypeResponse].self, data: data)
}


func savePost(post : Post){
    guard let file = Bundle.main.url(forResource: "data", withExtension: "json")
        else {fatalError("Cant load file")}
    do {
        let data = try JSONEncoder().encode(post);
        try data.write(to : file)
    } catch {print(error)
        fatalError("cant encode")}
}

func saveUser(user : User){
    guard let file = Bundle.main.url(forResource: "user", withExtension: "json")
        else {fatalError("Cant load file")}
    do {
        let data = try JSONEncoder().encode(user);
        try data.write(to : file)
    } catch {print(error)
        fatalError("cant encode")}
}

func getPost(id : String) -> Post{
    var post : Post = Post()
    guard let url = URL(string: "http://vps799211.ovh.net/posts/"+id) else {fatalError("url false")}
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
        
        DispatchQueue.main.async {
            do {
                post = try JSONDecoder().decode(Post.self,from: content)
                print(post)
            } catch {print(error)
                fatalError("cant decode")}
        }
        
    }.resume()
    return post
}

