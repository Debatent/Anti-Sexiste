//
//  PostView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 02/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI
import Combine

struct PostView: View {
    @State var showingAddResponseView = false
    @ObservedObject var post : Post
    
    var listTypeResponse : ListTypeResponse = ListTypeResponse()
    @State var currentTypeResponse : String = "Tout"
    
    @State var filteredListTypeResponse: [Response]
    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                VStack{
                    Text(self.post.title)
                        .font(.title)
                        .fontWeight(.thin)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing])
                    Text(self.post.message)
                        .multilineTextAlignment(.center)
                        .lineLimit(100)
                        .padding(.all)
                    VStack{
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.listTypeResponse.types) { type in
                                    Button(action: {
                                        if (type.typeResponse != "Tout"){
                                            self.filteredListTypeResponse = self.post.listResponse.filter { $0.typeResponse == type.typeResponse }
                                        }
                                        else{
                                            self.filteredListTypeResponse = self.post.listResponse
                                        }
                                    }) {
                                        VStack{
                                            Text(type.typeResponse)
                                                .font(.caption)
                                        }
                                        .padding(.leading)
                                    }
                                    
                                }
                            }
                        }
                        List{
                            ForEach(self.filteredListTypeResponse){ response in
                                ListRowResponseView(response:response)
                            }
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showingAddResponseView.toggle()
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
                                    y: 3).sheet(isPresented: $showingAddResponseView) {
                                        AddResponseView(showingAddPostView : self.$showingAddResponseView, post : self.post)
                        }
                    }
                }
                
            }
        }
        
    }
}

struct PostView_Previews: PreviewProvider {
    static let p = Post()
    static var previews: some View {
        PostView(post: self.p, filteredListTypeResponse : self.p.listResponse)
    }
}


///COM
