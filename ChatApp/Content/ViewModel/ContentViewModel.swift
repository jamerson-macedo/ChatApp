//
//  ContentViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import Foundation
import FirebaseAuth
class ContentViewModel : ObservableObject{
    // se tiver usuario
    @Published var isLogged = Auth.auth().currentUser != nil
    
    
    
    func onAppear(){
        Auth.auth().addStateDidChangeListener { auth, usuario in
            self.isLogged = usuario != nil
        }
    }
}
