//
//  SignUpView.swift
//  Anti-Sexiste
//
//  Created by etud on 06/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var userSession : UserSession
    @State var user : User = User()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    
    
    
    var body: some View {
        VStack{
            if (userSession.isConnected){
                Text("Vous êtes inscrit.")
            }
            else {
                Form{
                    Text("Inscrivez vous gratuitement pour avoir accès à plus de fonctionalitées !")
                        .font(.headline)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.center)
                        .padding(.all)
                    VStack{
                        Text("Email :")
                        TextField("email", text: $user.email)
                        Text("Pseudo :")
                        TextField("pseudo", text: $user.pseudo)
                        Text("Password :")
                        SecureField("password", text: $user.password)
                        
                    }
                    .padding(.all)
                    Button(action:{
                        
                        self.userSession.saveUser(user : self.user)
                        self.user = User()
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Text("S'incrire")
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
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
