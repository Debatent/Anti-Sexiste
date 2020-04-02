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
    @EnvironmentObject var appSession : AppSession
    
    
    @State private var showingAlert = false
    
    @State var showingAddPostView = false
    
    @State var currentPlace : String = "Tout"
    
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
                
                VStack{
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            Button(action: {
                                self.currentPlace = "Tout"
                                
                                
                            }) {
                                VStack{
                                    Image("Tout")
                                    Text("Tout")
                                        .font(.caption)
                                    
                                }
                                .padding(.leading)
                            }
                            
                            ForEach(self.appSession.listPlace) { place in
                                Button(action: {
                                    self.currentPlace = place.name
                                    
                                    
                                }) {
                                    VStack{
                                        Image(place.name)
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
                        ForEach(filterList(listPost: self.appSession.listPost, place: self.currentPlace)){ post in
                            
                            NavigationLink(destination: PostView(post: self.appSession.listPost.filter { $0._id! == post._id! }[0]).environmentObject(self.appSession)){
                                ListRowPostView(post:post).environmentObject(self.appSession)
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
                                        AddPostView(showingAddPostView: self.$showingAddPostView).environmentObject(self.appSession)
                        }
                    }
                }
            }.navigationBarItems(trailing:
                HStack {
                    if (appSession.isConnected){
                        Button(action : {
                            self.appSession.setUser(user: nil)
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
