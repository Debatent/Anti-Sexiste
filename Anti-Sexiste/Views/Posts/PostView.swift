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
    @EnvironmentObject var appSession : AppSession
    @State var showingAddResponseView = false
    @ObservedObject var post : Post
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var showingAlert = false
    @State private var showingVerification = false
    
    
    
    var failureMark: Alert {
        Alert(title: Text("Echec"), message: Text("Vous avez déjà voté pour ce post."), dismissButton: .default(Text("Ok")))
    }
    
    var verificationBox: Alert {
        Alert(title: Text("Supression du post"), message: Text("Voulez vous vraiment supprimer ce post ?"), primaryButton: .destructive(Text("Supprimer")) {
            DispatchQueue.main.async {
                self.appSession.deletePost(post: self.post, user : self.appSession.user!)
            }
            self.mode.wrappedValue.dismiss()
            }, secondaryButton: .cancel())
    }
    
    
    
    
    
    @State var currentTypeResponse : String = "Tout"
    var body: some View {
        
        VStack{
            ZStack{
                VStack{
                    Text(self.post.title).font(.title)
                    Text(self.post.message)
                        .multilineTextAlignment(.center)
                        .lineLimit(100)
                        .padding(.all)
                    VStack{
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Button(action: {
                                    self.currentTypeResponse = "Tout"
                                }) {
                                    HStack{
                                        Text("Tout")
                                            .font(.caption)
                                        
                                    }
                                    .padding(.leading)
                                }

                                ForEach(self.appSession.types) { type in
                                    Button(action: {
                                        self.currentTypeResponse = type.name
                                    }) {
                                        HStack{
                                            Text(type.name)
                                                .font(.caption)
                                            
                                        }
                                        .padding(.leading)
                                    }
                                    
                                }
                            }
                        }
                        List{
                            ForEach(filterResponse(listResponse: self.post.comments!, typeResponse: self.currentTypeResponse)){ response in
                                ListRowResponseView(response:response)
                            }
                        }
                    }
                }
                VStack{
                    Spacer()
                    HStack {
                        if (self.appSession.isConnected && self.post.author != nil){
                            if (self.post.author! == self.appSession.user!.pseudo){
                                HStack {
                                    Button(action: {
                                        self.showingVerification = true
                                    }, label: {
                                        Image(systemName: "trash").resizable()
                                            .font(.system(.caption))
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.white)
                                            .padding()
                                        
                                    }).alert(isPresented: $showingVerification, content: {self.verificationBox})
                                        .background(Color.red)
                                        .cornerRadius(38.5)
                                        .padding()
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                                    
                                }
                            }
                        }
                        
                        
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
                                            AddResponseView(showingAddResponseView : self.$showingAddResponseView, post : self.post).environmentObject(self.appSession)
                            }
                        }
                    }
                    
                }
            }
            
        }.navigationBarItems(trailing:
            HStack{
                if (appSession.isConnected){
                    Button(action: {
                        if (!self.appSession.incrementPost(user: self.appSession.user!, post: self.post)){
                            self.showingAlert = true
                        }
        
                    }) {
                        Image(systemName: "plus")
                    }.alert(isPresented: $showingAlert, content: {self.failureMark})
                }
                VStack{
                    Image(systemName: "flame").foregroundColor(.red)
                    Text(String(self.post.reaction))
                }
                
                
            }
        )
        
    }
}

struct PostView_Previews: PreviewProvider {
    static let p = Post()
    static var previews: some View {
        PostView(post: self.p)
    }
}


