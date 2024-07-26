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
    
    func getContacts (){
        guard let fromId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .collection("last-messages")
            .document(fromId)
            .collection("contacts")
            .addSnapshotListener { query, error in
                if let changes = query?.documentChanges{
                    for doc in changes{
                        if doc.type == .added{
                            let document = doc.document
                            self.contacts.removeAll()
                            self.contacts.append(Contacts(name: document.data()["username"] as! String ,  profileUrl: document.data()["photoUrl"] as! String, uuid: document.documentID, lastMessage:document.data()["lastMessage"]as! String, timeStamp: document.data()["timestamp"] as! UInt))
                        }
                    }
                }
        }
    }
    
}
