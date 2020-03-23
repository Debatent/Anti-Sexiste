//
//  AddResponseView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 03/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct AddResponseView: View {
    @EnvironmentObject var userSession : UserSession
    @Binding var showingAddResponseView: Bool
    @ObservedObject var post : Post
    @State private var selection : Int = 0
    @State var response : Response = Response()
    var listTypeResponse : ListTypeResponse
    
    
    var body: some View {
        VStack{
            Text("Ecrit ta réponse :")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
            Picker("Type :",selection: $selection) {
                ForEach(0 ..< listTypeResponse.types.count) { index in
                    Text(self.listTypeResponse.types[index].typeResponse).tag(index)
                    
                }
            }.labelsHidden()
            Form{
                VStack{
                    Text("Message :")
                    TextField("message", text: $response.message)
                }
                Button(action:{
                    self.response.type = self.listTypeResponse.types[self.selection].typeResponse
                    let today = Date()
                    let formatter1 = DateFormatter()
                    formatter1.dateStyle = .long
                    self.response.createdAt = formatter1.string(from: today)
                    if self.post.listResponse != nil{
                        self.post.listResponse!.append(self.response)}else{
                        self.post.listResponse = [self.response]
                    }
                    
                    
                    savePost(post: self.post)
                    self.response = Response()
                    self.showingAddResponseView = false
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

struct AddResponseView_Previews: PreviewProvider {
    static var previews: some View {
        AddResponseView(showingAddResponseView: .constant(false),post: Post(), listTypeResponse: ListTypeResponse())
    }
}
