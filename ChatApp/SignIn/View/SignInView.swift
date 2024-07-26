//
//  ContentView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel(repository: SignInRepository())
    var body: some View {
        NavigationView{
            ZStack{
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
                    
                    LoadingButton(action: viewModel.SignIn, disabled: viewModel.email.isEmpty || viewModel.password.isEmpty, showProgress: viewModel.uiState == SignInUiState.loading, text: "Entrar")
                    
                    Divider().padding()
                    NavigationLink(destination: SignUpView()){
                        Text("Não tem uma conta? Clique aqui").foregroundStyle(Color.black)
                    }
                    
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                    .padding(.horizontal,22)
                    .navigationTitle("Login")
                    .navigationBarHidden(true)
                if case SignInUiState.error(let value) = viewModel.uiState{
                    Text("")
                        .alert(isPresented: .constant(true)){
                            Alert(title: Text("ChatApp"), message: Text(value),dismissButton: .default(Text("Ok")){
                                // faz algo
                            })
                        }
                }
                
            }
        }
    }
}

#Preview {
    SignInView()
}
