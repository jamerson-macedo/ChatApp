//
//  MessagesRepository.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class MessagesRepository {
    func getContacts (completion : @escaping ([Contacts]) ->Void){
        var contacts : [Contacts] = []
        guard let fromId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .collection("last-messages")
            .document(fromId)
            .collection("contacts")
            .order(by: "timestamp",descending: true)
            .addSnapshotListener { query, error in
                if let changes = query?.documentChanges{
                    //contacts.removeAll()
                    for doc in changes{
                        if doc.type == .added{
                            let document = doc.document
                            contacts.append(Contacts(name: document.data()["username"] as! String,
                                                     profileUrl: document.data()["photoUrl"] as! String,
                                                     uuid: document.documentID,
                                                     lastMessage:document.data()["lastMessage"]as! String,
                                                     timeStamp: document.data()["timestamp"] as! UInt))
                        }
                    }
                }
                completion(contacts)
        }
    }
}
