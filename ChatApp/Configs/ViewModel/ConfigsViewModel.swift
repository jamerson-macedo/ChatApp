//
//  ConfigsViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import Foundation
import FirebaseAuth
class ConfigsViewModel : ObservableObject{
    func logout(){
        try? Auth.auth().signOut()
    }
}
