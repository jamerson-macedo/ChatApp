//
//  SignUpViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseStorage
import FirebaseFirestore
class SignUpViewModel :ObservableObject{
    @Published var uiState : SignUpUiState = .none
    @Published var image = UIImage()
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    var formInvalid = false
    @Published var alertText = ""
    
    private let repository :SignUpRepository
    
    init(repo:SignUpRepository){
        self.repository = repo
    }
    func signUp(){
        
        
        if(image.size.width <= 0 ){
            self.uiState = .error("Insira uma foto")
            return
        }
        self.uiState = .loading
        repository.signUp(withEmail: email, password: password, image: image, name: name){ err in
            if let err = err{
                self.uiState = .error(err)
            }
            self.uiState = .success
        }
    }
   
}
