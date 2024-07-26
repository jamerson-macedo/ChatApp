//
//  ContacsViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
class ContactsViewModel : ObservableObject{
    @Published var contacts : [Contacts] = []
    @Published var uiState :ContactsUiState = .none
    var isloaded = false
    private let repository : ContactsRepository
    
    init(repo: ContactsRepository) {
     
        self.repository = repo
    }
    func getContacts(){
        
        self.uiState = .loading
        
        repository.getContacts(){ contacts,err  in
            if let err = err{
                self.uiState = .error(err)
            }
            self.contacts.removeAll()
            self.contacts.append(contentsOf:contacts)
            self.uiState = .success
        
        }
    }
        
        
    
    
}
