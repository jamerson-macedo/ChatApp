//
//  SignUpView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = SignUpViewModel(repo: SignUpRepository())
    @State var isShowPhotoLibrary = false
    var body: some View {
        ZStack{
            ScrollView{
                VStack {
                    
                    HStack{
                        Image("iconwhats").resizable().scaledToFit().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                        Text("Chat App").font(.title).bold().offset(CGSize(width:-10, height: 0))
                    }
                    Button(action: {
                        isShowPhotoLibrary.toggle()
                        
                    }, label: {
                        if viewModel.image.size.width  > 0{
                            Image(uiImage: viewModel.image).resizable().scaledToFill().frame(width: 130,height: 130)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.green,lineWidth: 3))
                                .shadow(radius: 7)
                            
                        }else {
                            Image(systemName:"person.badge.plus").resizable().padding(15).scaledToFill().frame(width: 130,height: 130,alignment: .center)
                                .foregroundStyle(Color.green)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.green,lineWidth: 3))
                                .shadow(radius: 7)
                        }
                    }).padding(.bottom,32)
                        .sheet(isPresented: $isShowPhotoLibrary) {
                            ImagePicker(selectedImage: $viewModel.image)
                        }
                    fullNameField
                    emailField
                    passwordField
                    
                    
                    enterButton
                    Divider().padding()
                    
                    Button(action: {
                        viewModel.signUp()
                        
                    }, label: {
                        Text("Ja tem uma conta? Clique aqui").foregroundStyle(Color.black)
                    })
                    
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                    .padding(.horizontal,22)
                
            }
            if case SignUpUiState.error(let value) = viewModel.uiState{
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("ChatApp"), message: Text(value),dismissButton: .default(Text("Ok")))
                    }
            }
            
            
            
        }
    }
}
extension SignUpView{
    var enterButton : some View{
        LoadingButton(action: {
            viewModel.signUp()
        }, disabled: viewModel.email.isEmpty || viewModel.password.isEmpty,
                      showProgress: self.viewModel.uiState == SignUpUiState.loading, text: "Realize Seu cadastro"
        )
    }
}
extension SignUpView{
    var fullNameField : some View{
        TextField("Digite seu nome ",text:$viewModel.name)
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
    }
}
extension SignUpView{
    var emailField:some View{
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
    }
}
extension SignUpView{
    var passwordField : some View{
        SecureField("Entre com sua senha", text: $viewModel.password).padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color.green,style: StrokeStyle(lineWidth: 1.0))
            )
            .padding(.bottom,20)
    }
}

#Preview {
    SignUpView()
}
