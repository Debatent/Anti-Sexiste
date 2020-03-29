//
//  ProfilView.swift
//  Anti-Sexiste
//
//  Created by etud on 11/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct ProfilView: View {
    @EnvironmentObject var appSession : AppSession

    var body: some View {
        VStack{
            if(appSession.isConnected){
                Text(appSession.user!.pseudo)
            }
        }
        
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
