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
    var isloaded = false
    
    
    func getContacts(){
        if isloaded {return}
        Firestore.firestore().collection("users").getDocuments { querySnapshot, err in
            if let err = err {
                print("error \(err)")
                return
            }else {
                for document in querySnapshot!.documents{
                    if Auth.auth().currentUser?.uid != document.documentID{
                        print("Documentos \(document.data())") // dados vindo
                        self.contacts.append(Contacts(name: document.data()["name"] as! String,
                                                      profileUrl: document.data()["profileUrl"] as! String ,
                                                      uuid: document.documentID))
                    }
                }
                self.isloaded = true
            }
        }
        
    }
    
}
