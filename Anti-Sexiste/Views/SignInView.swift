//
//  SignInView.swift
//  Anti-Sexiste
//
//  Created by etud on 06/03/2020.
//  Copyright © 2020 user165109. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var userSession : UserSession
    @State var email : String = ""
    @State var password : String = ""
    var body: some View {
        VStack{
            if (userSession.isConnected){
                ProfilView()
            }
            else {
                Form{
                    Text("Vous avez déjà un compte ? connectez vous !")                       .font(.headline)
                        .fontWeight(.thin)
                        .multilineTextAlignment(.center)
                        .padding(.all)
                    VStack{
                        Text("Email :")
                        TextField("email", text: $email)
                        Text("Password :")
                        SecureField("password", text: $password)
                        
                    }
                    .padding(.all)
                    Button(action:{
                        
                        
                    }) {
                        Text("Connexion")
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
