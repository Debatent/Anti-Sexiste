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
    @EnvironmentObject var userSession : UserSession
    @State var showingAddResponseView = false
    @ObservedObject var post : Post
    @ObservedObject var listPost : ListPost
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var showingAlert = false
    @State private var showingVerification = false
    
    var failureMark: Alert {
        Alert(title: Text("Echec"), message: Text("Vous avez déjà voté pour ce post."), dismissButton: .default(Text("Ok")))
    }
    
    var verificationBox: Alert {
        Alert(title: Text("Supression du post"), message: Text("Voulez vous vraiment supprimer ce post ?"), primaryButton: .destructive(Text("Supprimer")) {
            self.listPost.deletePost(post: self.post)
            self.mode.wrappedValue.dismiss()
            }, secondaryButton: .cancel())
    }
    
    
    var listTypeResponse : ListTypeResponse = ListTypeResponse()
    
    
    
    @State var currentTypeResponse : String = "Tout"
    var body: some View {
        
        VStack{
            ZStack{
                VStack{
                    Text(self.post.message)
                        .multilineTextAlignment(.center)
                        .lineLimit(100)
                        .padding(.all)
                    VStack{
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(self.listTypeResponse.types) { type in
                                    Button(action: {
                                        self.currentTypeResponse = type.typeResponse
                                    }) {
                                        HStack{
                                            Text(type.typeResponse)
                                                .font(.caption)
                                            
                                        }
                                        .padding(.leading)
                                    }
                                    
                                }
                            }
                        }
                        List{
                            ForEach(filterResponse(listResponse: self.post.listResponse!, typeResponse: self.currentTypeResponse)){ response in
                                ListRowResponseView(response:response)
                            }
                        }
                    }
                }
                VStack{
                    Spacer()
                    HStack {
                        if (self.userSession.isConnected && self.post.author != nil){
                            if (self.post.author! == self.userSession.user!.pseudo){
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
                                            AddResponseView(showingAddResponseView : self.$showingAddResponseView, post : self.post, listTypeResponse: self.listTypeResponse).environmentObject(self.userSession)
                            }
                        }
                    }
                    
                }
            }
            
        }.navigationBarTitle(post.title).navigationBarItems(trailing:
            HStack{
                if (userSession.isConnected){
                    Button(action: {
                        if (!self.post.increment(user: self.userSession.user!)){
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
        PostView(post: self.p, listPost: ListPost())
    }
}


///COM
