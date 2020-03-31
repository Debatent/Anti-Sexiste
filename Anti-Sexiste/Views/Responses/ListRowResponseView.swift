//
//  ListRowResponseView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 02/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct ListRowResponseView: View {
    @EnvironmentObject var appSession : AppSession
    @State private var showingAlertComment = false
    @State private var showingAlertCommentReport = false
      
      var failureNotConnected: Alert {
          Alert(title: Text("Echec"), message: Text("Connectez vous pour pouvoir interagir avec la communautée."), dismissButton: .default(Text("Ok")))
      }
    
    var failureMarkCommentReport: Alert {
        Alert(title: Text("Echec"), message: Text("Vous avez déjà signalé ce post."), dismissButton: .default(Text("Ok")))
    }
    @ObservedObject var response : Response
    @ObservedObject var post : Post

    
    var body: some View {
        HStack{
            Text(response.message)
            Spacer()
            HStack{
                VStack{
                    Image(systemName: "flame").foregroundColor(.red)
                    Text(String(self.response.reaction))
                }.gesture(TapGesture().onEnded() {
                    if(self.appSession.isConnected){
                        if(!self.appSession.user!.commentReaction.contains(self.response._id!)){
                            self.appSession.incrementCommentReaction(user: self.appSession.user!, post: self.post, response: self.response)
                        }else{
                            self.appSession.decrementCommentReaction(user: self.appSession.user!, post: self.post, response : self.response)
                        }
                    }else{
                        self.showingAlertComment = true
                    }
                }).alert(isPresented: $showingAlertComment, content: {self.failureNotConnected})
                

                VStack{
                    Image(systemName: "heart.slash").foregroundColor(.red)
                    Text(String(self.response.report))
                }.gesture(TapGesture().onEnded() {
                    if (self.appSession.isConnected){
                        if(!self.appSession.incrementCommentReport(user: self.appSession.user!, post: self.post, response : self.response)){
                            self.showingAlertCommentReport = true
                        }
                        
                    }else{
                        self.showingAlertComment = true
                    }
                }).alert(isPresented: $showingAlertCommentReport, content: {self.failureMarkCommentReport})
                
            }
        }
        
    }
}

struct ListRowResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowResponseView(response: Response(), post : Post())
    }
}
