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
                Text("Chat App").font(.title).bold().offset(CGSize(width:-10, height: 0))
            }
            
            TextField("Entre com seu E-mail",text:$viewModel.email)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .padding()
                .background(Color.white)
                .cornerRadius(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .strokeBorder(Color.green,style: StrokeStyle(lineWidth: 1.0))
                )
                .padding(.bottom,20)
            
            SecureField("Entre com sua senha", text: $viewModel.password).padding()
                .background(Color.white)
                .cornerRadius(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .strokeBorder(Color.green,style: StrokeStyle(lineWidth: 1.0))
                )
                .padding(.bottom,20)
            
            Button(action: {
                viewModel.SignIn()
                
            }, label: {
                
                Text("Entrar")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            })
            Divider().padding()
            
            Button(action: {
                
            }, label: {
                Text("Não tem uma conta? Clique aqui").foregroundStyle(Color.black)
            })
           
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .padding(.horizontal,22)
    
    }
}

#Preview {
    SignInView()
}
