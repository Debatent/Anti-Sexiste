//
//  ListRowResponseView.swift
//  Anti-Sexiste
//
//  Created by user165109 on 02/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct ListRowResponseView: View {
    var response : Response
    init(response : Response){
        self.response = response
    }
    
    var body: some View {
        Text(response.message)
    }
}

struct ListRowResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowResponseView(response: Response())
    }
}
