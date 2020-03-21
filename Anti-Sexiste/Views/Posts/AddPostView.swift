//
//  AddPostView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 03/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct AddPostView: View {
    @EnvironmentObject var userSession : UserSession
    @Binding var showingAddPostView: Bool
    @State private var selection : Int = 0
    @State var post : Post = Post()
    var listPlace : ListPlace
    @ObservedObject var listPost : ListPost
    var body: some View {
        VStack{
            Text("Ecrit ton post :")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
            Picker("Lieu",selection: $selection) {
                ForEach(0 ..< listPlace.places.count) { index in
                    Text(self.listPlace.places[index].place).tag(index)
                    
                }
            }.labelsHidden()
            Form{
                VStack{
                    Text("Titre :")
                    TextField("titre", text: $post.title)
                    Text("Message :")
                    TextField("message", text: $post.message)
                }
                Button(action:{
                    self.post.location = self.listPlace.places[self.selection].place
                    let today = Date()
                    let formatter1 = DateFormatter()
                    formatter1.dateStyle = .long
                    self.post.createdAt = formatter1.string(from: today)
                    if (self.userSession.isConnected){
                        self.post.author = self.userSession.user!.pseudo
                    }
                    self.listPost.addPost(post: self.post)
                    savePost(post: self.post)
                    self.post = Post()
                    self.showingAddPostView = false
                }) {
                    Text("Publier")
                }.frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.blue), Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
            }
            
            
            
        }
        
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView(showingAddPostView: .constant(false),listPlace: ListPlace(), listPost : ListPost())
    }
}
