//
//  AddPostView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 03/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct AddPostView: View {
    @State private var selection : Int = 0
    @State var post : Post = Post()
    var listPlace : ListPlace
    @ObservedObject var listPost : ListPost
    var body: some View {
        VStack{
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
                self.post.placePost = self.listPlace.places[self.selection].place
                let today = Date()
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .long
                self.post.date = formatter1.string(from: today)
                print(self.post)
                self.listPost.addPost(post: self.post)
                self.post = Post()
            }) {
                Text("Go")
                    .multilineTextAlignment(.center)
            }
            .padding(5.0)
            }
        }
        
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView(listPlace: ListPlace(), listPost : ListPost())
    }
}
