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
    
    private let repository : SignInRepository
    init(repository :SignInRepository){
        self.repository = repository
    }
    var formInvalid = false
    @Published var alertText = ""
    func SignIn(){
        self.uiState = .loading
        repository.signIn(withEmail: email, password: password){ err in
            if let  err = err{
                self.uiState = .error(err)
                return
            }
            self.uiState = .success
            
            
            
        }
        
        
       
        
    }
}
