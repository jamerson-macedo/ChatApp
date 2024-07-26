//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
class ChatViewModel : ObservableObject{
    @Published var messages : [Message] = []
    @Published var text = ""
    var myName = ""
    var myPhoto = ""
    let limit = 20
    var insert = false
    var newCount = 0
    
    func onAppear(contact:Contacts){
        guard let fromId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .collection("users")
            .document(fromId).getDocument { snapshot, error in
                if let err = error{
                    print("Error\(err)")
                    return
                }
                if let document = snapshot?.data(){
                    self.myName = document["name"] as! String
                    self.myPhoto = document["profileUrl"] as! String
                }
                
            }
        
        Firestore.firestore().collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .order(by: "timestamp",descending: true)
            .start(after: [self.messages.last?.timestamp ?? 9999999999999])
            .limit(to: limit)
            .addSnapshotListener{ query, error in
                if let err = error{
                    print("Error\(err)")
                    return
                }
                // toda vez que mudar ja recebe aqui
                if let changes = query?.documentChanges{
                    for doc in changes{
                        if doc.type == .added{
                            let document = doc.document
                            let message = Message(uuid: document.documentID, text: document.data()["text"] as! String, isMe: fromId == document.data()["fromId"] as! String,timestamp: document.data()["timestamp"] as! UInt)
                            
                            if self.insert{
                                self.messages.insert(message, at: 0)
                            }else {
                                self.messages.append(message)
                            }
                        }
                    }
                    self.insert = false
                }
                self.newCount = self.messages.count
            
        }
    }
    
    func sendMessage(contact:Contacts){
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        insert = true
        self.newCount = newCount + 1
        //self.text = ""
        let fromId = Auth.auth().currentUser!.uid
        let timeStamp = Date().timeIntervalSince1970
        Firestore.firestore()
            .collection("conversations")
            .document(fromId)
            .collection(contact.uuid)
            .addDocument(data:[
                "text": text,
                "fromId":fromId,
                "toId" : contact.uuid,
                "timestamp": UInt(timeStamp) // interio que n permite negativos
            ]){ err in
                if err != nil{
                    print(err!.localizedDescription)
                    return
                }
                Firestore.firestore().collection("last-messages")
                    .document(fromId)
                    .collection("contacts")
                    .document(contact.uuid)
                    .setData([
                        "uid":contact.uuid,
                        "username" : contact.name,
                        "photoUrl" : contact.profileUrl,
                        "timestamp" : UInt(timeStamp),
                        "lastMessage" : self.text
                    ])
                
            }
        Firestore.firestore()
            .collection("conversations")
            .document(contact.uuid)
            .collection(fromId)
            .addDocument(data:[
                "text": text,
                "fromId":fromId,
                "toId" : contact.uuid,
                "timestamp": UInt(timeStamp) // interio que n permite negativos
            ]){ err in
                if err != nil{
                    print(err!.localizedDescription)
                    return
                }
                Firestore.firestore().collection("last-messages")
                    .document(contact.uuid)
                    .collection("contacts")
                    .document(fromId)
                    .setData([
                        "uid":fromId,
                        "username" : self.myName,
                        "photoUrl" : self.myPhoto,
                        "timestamp" : UInt(timeStamp),
                        "lastMessage" : self.text
                    ])
                
            }
        
    }
}
