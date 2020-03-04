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
    
    @State var showingAddPostView = false
    
    var listPlace : ListPlace = ListPlace()
    @State var currentPlace : String = "Tout"
    
    @State var filteredListPost: [Post] = ListPost().listPost
    
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack{
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.listPlace.places) { place in
                                Button(action: {self.currentPlace = place.place
                                    self.filteredListPost = self.listPost.filterList(place:place.place)
                                }) {
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
                            NavigationLink(destination: PostView(post: post, filteredListTypeResponse : post.listResponse)){
                                ListRowPostView(post:post)
                                
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showingAddPostView.toggle()
                        }, label: {
                            Image(systemName: "pencil.tip")
                                .font(.system(.largeTitle))
                                .frame(width: 57, height: 50)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 7)
                        })
                            .background(Color.blue)
                            .cornerRadius(38.5)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3).sheet(isPresented: $showingAddPostView) {
                                        AddPostView(showingAddPostView: self.$showingAddPostView, listPlace: self.listPlace, listPost: self.listPost)
                        }
                    }
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
