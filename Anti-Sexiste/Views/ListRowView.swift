//
//  ListRowView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 29/02/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct ListRowView: View {
    var post : Post
    init(post : Post){
        self.post = post
    }
    var body: some View {
        Text(self.post.message)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(post: Post())
    }
}
