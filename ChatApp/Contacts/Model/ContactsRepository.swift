//
//  ContactsRepository.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class ContactsRepository {
    func getContacts(completion: @escaping ([Contacts],String?) -> Void) {
        var contacts: [Contacts] = []
      
       
        Firestore.firestore().collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Erro ao buscar contatos: \(error)")
                    completion([],error.localizedDescription)
                    return
                }
                
               
                for document in querySnapshot!.documents {
                    if Auth.auth().currentUser?.uid != document.documentID {
                        print("ID \(document.documentID) \(document.data())")
                        contacts.append(Contacts(name: document.data()["name"] as! String,
                                                 profileUrl: document.data()["profileUrl"] as! String,
                                                 uuid: document.documentID ))
                    }
                }
              
                
                completion(contacts,nil)
            }
    }
}
