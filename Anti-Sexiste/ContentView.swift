//
//  ContentView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 25/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var listPost : ListPost
    init(){
        let data : Data
        guard let file = Bundle.main.url(forResource: "data", withExtension: "json")
            else {fatalError("Cant load file")}
    

        do {
            data = try Data(contentsOf: file)
        }catch {fatalError("cant open content")}
        
        do {
            
            let decoder = JSONDecoder()
            let Posts : [Post] = try decoder.decode([Post].self,from:data)
            
            
            self.listPost = ListPost(listPost : Posts)
            
        } catch {print(error)
            fatalError("cant decode")}
    }
    
    var body: some View {
        NavigationView{
        VStack {
            List(self.listPost.getListPost())
            { post in
                ListRowView(post:post)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
