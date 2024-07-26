//
//  SignInRepository.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation
import FirebaseAuth
class SignInRepository {
    func signIn(withEmail: String, password: String,completion : @escaping (String?) -> Void){
        
        Auth.auth().signIn(withEmail: withEmail, password: password){ result, error in
            guard let user = result?.user, error == nil else {
                completion(error?.localizedDescription)
                
                //self.uiState = .error(error?.localizedDescription ?? "Erro desconhecido")
                return
            }
            completion(nil)
            print("Usuario criado\(user.uid)")
            
        }
    }
}
