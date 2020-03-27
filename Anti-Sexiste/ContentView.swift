//
//  ContentView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 25/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI
import Combine


struct ContentView: View {
    @EnvironmentObject var userSession : UserSession
    @ObservedObject var listPost : ListPost = ListPost()
    
    
    @State private var showingAlert = false

    @State var showingAddPostView = false
    
    @ObservedObject var listPlace : ListPlace = ListPlace()
    @State var currentPlace : String = "Tout"
    
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
                
                VStack{

                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            
                            ForEach(self.listPlace.places) { place in
                                Button(action: {
                                    self.currentPlace = place.name
                                        
                                    
                                }) {
                                    VStack{
                                        Text(place.name)
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
                        ForEach(filterList(listPost: self.listPost.listPost, place: self.currentPlace)){ post in
                            NavigationLink(destination: PostView(post: Post(id: post._id!), listPost: self.listPost).environmentObject(self.userSession)){
                                ListRowPostView(post:post).environmentObject(self.userSession)
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
                            Image(systemName: "text.bubble").resizable()
                                .font(.system(.caption))
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.white)
                                .padding()
                            
                        })
                            .background(Color.blue)
                            .cornerRadius(38.5)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3).sheet(isPresented: $showingAddPostView) {
                                        AddPostView(showingAddPostView: self.$showingAddPostView, listPlace: self.listPlace, listPost: self.listPost).environmentObject(self.userSession)
                        }
                    }
                }
            }.navigationBarItems(trailing:
                HStack {
                    if (userSession.isConnected){
                        Button(action : {
                            self.userSession.setUser(user: nil)
                            self.showingAlert = true
                        }){
                            Image("icons8-shutdown-50")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        }
                    }
                    NavigationLink(destination: SignInView()) {
                        Image("icons8-account-50")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        
                    }
                    NavigationLink(destination: SignUpView()) {
                        Image("icons8-google-forms-50")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                    
                }
            )
            
            
        }.alert(isPresented: $showingAlert) {
        Alert(title: Text("Zzziouuuuff"), message: Text("Vous avez été déconnecté !"), dismissButton: .default(Text("Super")))
            }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
