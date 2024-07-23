//
//  SignInViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import Foundation
import FirebaseAuth
class SignInViewModel : ObservableObject{
    @Published var email : String = ""
    @Published var password: String = ""
    @Published var uiState : SignInUiState = .none
    var formInvalid = false
    @Published var alertText = ""
    func SignIn(){
        self.uiState = .loading
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            guard let user = result?.user, error == nil else {
                self.alertText = error!.localizedDescription
                print(error)
                self.uiState = .error(error?.localizedDescription ?? "Erro desconhecido")
                return
            }
            self.uiState = .success
            print("Usuario criado\(user.uid)")
            
        }
        
    }
}
