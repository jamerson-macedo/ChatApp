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
class SignUpViewModel :ObservableObject{
    @Published var uiState : SignUpUiState = .none
    @Published var image = UIImage()
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    var formInvalid = false
    @Published var alertText = ""
    func signUp(){
       
        
        if(image.size.width <= 0 ){
            self.uiState = .error("Insira uma foto")
            return
        }
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
            self.uploadPhoto()
        }
    }
    private func uploadPhoto(){
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else {return }
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data,metadata: newMetadata){ metadata, error in
            ref.downloadURL{ url,error in
                self.uiState = .success
                print("foto criada\(url)")
                
            }
        }
    }
}
