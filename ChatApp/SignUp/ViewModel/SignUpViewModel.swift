//
//  SignUpViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import Foundation
import FirebaseAuth
class SignUpViewModel :ObservableObject{
    @Published var uiState : SignUpUiState = .none
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    var formInvalid = false
    @Published var alertText = ""
    func signUp(){
        self.uiState = .loading
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            guard let user = result?.user, error == nil else {
                self.formInvalid = true
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
