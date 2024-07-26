//
//  MessagesViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class MessagesViewModel :ObservableObject{
    
    @Published var contacts : [Contacts] = []
    private let repository : MessagesRepository
    private var handleEnabled = true
    init(repo:MessagesRepository){
        self.repository = repo
    }
    func handleEnabled(enabled :Bool){
        self.handleEnabled = enabled
        
    }
    func getContacts(){
        repository.getContacts(){ contact in
            if self.handleEnabled {
                self.contacts = contact
            }else {
                print("contatos")
            }
            
        }
    }
    
    
    
}
