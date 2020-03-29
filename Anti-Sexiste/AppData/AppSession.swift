//
//  UserSession.swift
//  Anti-Sexiste
//
//  Created by etud on 10/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class AppSession:ObservableObject,Identifiable{
    @Published var isConnected : Bool
    @Published var user : User?
    @Published var listPost : [Post] = []
    @Published var listPlace : [Place] = []
    @Published var types : [TypeResponse] = []

    init(user : User?){
        self.user = user
        
        if (user != nil){
            self.isConnected = true
        }
        else {
            self.isConnected = false
        }
        
        self.loadListPost()
        self.loadListPlace()
        self.loadListTypeResponse()
    }
    
    func setUser(user : User?){
        if let user = user{
            self.isConnected = true
            self.user = user
        }
        else {
            self.isConnected = false
            self.user = nil
        }
    }
    
    
    func saveUser(user : User){
        guard let data = try? JSONEncoder().encode(user) else {
            fatalError("Cant load file")
        }
        if let url = URL(string: "https://azur-vo.fr/register") {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            request.httpBody = data
            
            
            URLSession.shared.dataTask(with: request){data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {print(response!)
                        
                        return
                }
                
                
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let content = data else {
                    print("No data")
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        let user : User = try JSONDecoder().decode(User.self, from: content)
                        if let token = httpResponse.value(forHTTPHeaderField: "auth-token") {
                            user.token = token
                        }
                        self.setUser(user: user)
                    } catch {print(error)
                        fatalError("cant decode")}
                }
                
            }.resume()
        }
    }
    
    func login(pseudo : String, password : String){
        let body = [ "user" : pseudo, "password" : password]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        if let url = URL(string: "https://azur-vo.fr/login") {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            request.httpBody = finalBody
            
            
            URLSession.shared.dataTask(with: request){data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {print(response!)
                        
                        return
                }
                
                
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let content = data else {
                    print("No data")
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        let user : User = try JSONDecoder().decode(User.self, from: content)
                        if let token = httpResponse.value(forHTTPHeaderField: "auth-token") {
                            user.token = token
                        }
                        self.setUser(user: user)
                    } catch {print(error)
                        fatalError("cant decode")}
                }
                
            }.resume()
        }
    }
    
    func incrementPost(user : User, post : Post)->Bool{
        if (!user.postReaction.contains(post._id!)){
            guard let data = try? JSONEncoder().encode(post) else {
                fatalError("Cant load file")
            }
            
            
            if let url = URL(string: "https://azur-vo.fr/posts/"+post._id!+"/like") {
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue(user.token, forHTTPHeaderField: "auth-token")
                request.httpMethod = "PATCH"
                request.httpBody = data
                
                URLSession.shared.dataTask(with: request){data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {print(response!)
                            
                            return
                    }
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    
                    
                    
                }.resume()
                self.user!.postReaction.append(post._id!)
                if let index = self.listPost.firstIndex(where: {$0._id! == post._id!}){
                    self.listPost[index].reaction += 1
                }
                return true
            }
        }
        return false
    }
    
    
    
    
    func loadListPost(){
        guard let url = URL(string: "https://azur-vo.fr/posts") else {fatalError("url false")}
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
                    self.listPost = try JSONDecoder().decode([Post].self,from: content)
                } catch {print(error)
                    fatalError("cant decode")}
            
            
            
            
            
            
        }.resume()
    }
    
    
    func addPost(post: Post, user : User?){
        guard let data = try? JSONEncoder().encode(post) else {
            fatalError("Cant load file")
        }
        
        
        if let url = URL(string: "https://azur-vo.fr/posts") {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let user = user {
                
                request.setValue(user.token, forHTTPHeaderField: "auth-token")
            }
            
            
            request.httpMethod = "POST"
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request){data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {print(response!)
                        
                        return
                }
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let content = data else {
                    print("No data")
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        let post : Post = try JSONDecoder().decode(Post.self, from: content)
                        self.listPost.append(post)
                    } catch {print(error)
                        fatalError("cant decode")}
                }
                
            }.resume()
        }
    }
    
    
    
    func deletePost(post : Post, user : User){
        if let index = self.listPost.firstIndex(where: {$0._id! == post._id!}) {
            
            let body = [ "idPost" : post._id!]
            let finalBody = try! JSONSerialization.data(withJSONObject: body)
            if let url = URL(string: "https://azur-vo.fr/posts/"+post._id!) {
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                request.setValue(user.token, forHTTPHeaderField: "auth-token")
                
                
                request.httpMethod = "DELETE"
                request.httpBody = finalBody
                
                URLSession.shared.dataTask(with: request){data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {print(response!)
                            
                            return
                    }
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    
                    
                }.resume()
            }
            self.listPost.remove(at: index)
        }
    }
    
    
    
    
    func addResponse(response: Response, user : User?, post : Post){
        guard let data = try? JSONEncoder().encode(response) else {
            fatalError("Cant load file")
        }
        
        
        if let url = URL(string: "https://azur-vo.fr/posts/"+post._id!) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let user = user {
                request.setValue(user.token, forHTTPHeaderField: "auth-token")
            }
            
            
            request.httpMethod = "POST"
            request.httpBody = data
            print(String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed")
            URLSession.shared.dataTask(with: request){data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {print(response!)
                        
                        return
                }
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let content = data else {
                    print("No data")
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        let response : Response = try JSONDecoder().decode(Response.self, from: content)
                        if let index = self.listPost.firstIndex(where: {$0._id! == post._id!}){
                            self.listPost[index].comments?.append(response)
                        }
                    } catch {print(error)
                        fatalError("cant decode")}
                }
                
            }.resume()
        }
    }
    
    
    func loadListPlace(){
        guard let url = URL(string: "https://azur-vo.fr/labels/posts") else {fatalError("url false")}
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
                    self.listPlace = try JSONDecoder().decode([Place].self,from: content)
                    print(self.listPlace)
                } catch {print(error)
                    fatalError("cant decode")}
                
            
            
            
        }.resume()
    }
    
    func loadListTypeResponse(){
        guard let url = URL(string: "https://azur-vo.fr/labels/comments") else {fatalError("url false")}
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



func filterList(listPost : [Post],place : String)-> [Post]{
    if (place != "Tout"){
        return listPost.filter { $0.location == place }
    }
    else{
        return listPost
    }
}

func filterResponse(listResponse : [Response], typeResponse : String)->[Response]{
    if (typeResponse != "Tout"){
        return  listResponse.filter { $0.type == typeResponse }
    }
    else{
        return listResponse    }
}


enum UserSessionError: Error {
    case notConnected
}
