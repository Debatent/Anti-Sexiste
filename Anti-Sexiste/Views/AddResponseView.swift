//
//  AddResponseView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 03/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct AddResponseView: View {
    @Binding var showingAddPostView: Bool
    @ObservedObject var post : Post
    @State private var selection : Int = 0
    @State var response : Response = Response()
    
    var body: some View {
        VStack{
            Text("")
        }
        
    }
}

struct AddResponseView_Previews: PreviewProvider {
    static var previews: some View {
        AddResponseView(showingAddPostView: .constant(false),post: Post())
    }
}
