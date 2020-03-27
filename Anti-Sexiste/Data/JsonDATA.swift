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



func getPlaces() -> [Place]{
    let data : Data = loadDATA(file: "place")
    return decodeJsonData(returnType: [Place].self, data: data)
}

func getTypeResponse()-> [TypeResponse]{
    let data : Data = loadDATA(file: "typeResponse")
    return decodeJsonData(returnType: [TypeResponse].self, data: data)
}






