//
//  ContentView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    var body: some View {
        VStack {
            HStack{
                Image("iconwhats").resizable().scaledToFit().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                Text("Chat App").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().offset(CGSize(width:-10, height: 0))
            }
            
            TextField("Entre com seu E-mail",text:$viewModel.email).padding().border(Color.green)
            
            SecureField("Entre com sua senha", text: $viewModel.password).padding().border(Color.green)
            
            Button(action: {
                viewModel.SignIn()
                
            }, label: {
                Text("Entrar")
            })
            Divider()
            
            Button(action: {
                
            }, label: {
                Text("Não tem uma conta? Clique aqui")
            })
           
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
