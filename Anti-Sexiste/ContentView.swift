//
//  ContentView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 25/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI
import Combine
import UIKit
import PhotosUI


struct ContentView: View {
    
    
    
    @ObservedObject var listPost : ListPost = ListPost()
    
    
    
    var listPlace : ListPlace = ListPlace()
    @State var currentPlace : String = "Tout"
    
   var filteredListPost: [Post] {
       switch currentPlace {
       case "Tout":
        return listPost.listPost
       case "Rue":
        return listPost.listPost.filter { $0.placePost == "Rue" }
       case "A la maison":
       return listPost.listPost.filter { $0.placePost == "A la maison" }
        case "A l'école":
         return listPost.listPost.filter { $0.placePost == "A l'école" }
        case "Au travail":
        return listPost.listPost.filter { $0.placePost == "Au travail" }
       default:
        return listPost.listPost
        }
   }
    
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                        ForEach(self.listPlace.places) { place in
                            Button(action: {self.currentPlace = place.place}) {
                                VStack{
                                    Image(place.icon).resizable()
                                    .frame(width: 30, height: 30)
                                    Text(place.place)
                                        .font(.caption)
                                }
                                .padding(.leading)
                            }
                            
                           }
                       }
                }
                Text(currentPlace)
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.top)

                
                List{
                    ForEach(self.filteredListPost){ post in
                            NavigationLink(destination: PostView(post: post)){
                        ListRowPostView(post:post)
                                        
                                   }
                               }
                           }
                NavigationLink(destination: AddPostView(listPlace: listPlace, listPost: listPost)){
                Text("ajoute un post")
                                
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
