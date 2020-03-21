//
//  ListRowView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 29/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI
import Combine

struct ListRowPostView: View {
    @ObservedObject var post : Post
    @EnvironmentObject var userSession : UserSession
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading, spacing: 20){
                Text(post.title)
                    .font(.title)
                    .fontWeight(.thin)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                Text(post.message)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.all)
                Text(post.createdAt)
                    .font(.caption)
                    .fontWeight(.ultraLight)
                    .multilineTextAlignment(.trailing)
                
            }
            Spacer()
            VStack{
                Image(systemName: "flame").foregroundColor(.red)
                Text(String(post.reaction))
            }
            
        }
        
        
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowPostView(post: Post())
    }
}
