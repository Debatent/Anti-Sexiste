//
//  UserSession.swift
//  Anti-Sexiste
//
//  Created by etud on 10/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import Foundation

class UserSession:ObservableObject{
    @Published var isConnected : Bool
    @Published var user : User?
    
    init(user : User?){
        self.user = user
        if (user != nil){
            self.isConnected = true
        }
        else {
            self.isConnected = false
        }
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
        if let url = URL(string: "http://vps799211.ovh.net/register") {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            request.httpBody = data
            print(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")
            
            
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
                        print(user)
                    } catch {print(error)
                        fatalError("cant decode")}
                }
                
            }.resume()
        }
    }
    
    func login(pseudo : String, password : String){
        let body = [ "user" : pseudo, "password" : password]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        if let url = URL(string: "http://vps799211.ovh.net/login") {
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
                print(String(data: content, encoding: String.Encoding.utf8) ?? "")

                DispatchQueue.main.async {
                    do {
                        let user : User = try JSONDecoder().decode(User.self, from: content)
                        if let token = httpResponse.value(forHTTPHeaderField: "auth-token") {
                            user.token = token
                        }
                        self.setUser(user: user)
                        print(user)
                    } catch {print(error)
                        fatalError("cant decode")}
                }
                
            }.resume()
        }
    }
    
    
    
}

enum UserSessionError: Error {
    case notConnected
}
