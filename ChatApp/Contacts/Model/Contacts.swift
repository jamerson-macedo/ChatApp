//
//  Contacts.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import Foundation
struct Contacts: Hashable,Decodable{
    let name : String
    let profileUrl:String
    let uuid : String
    var lastMessage : String?
    var timeStamp :UInt?
    
    init(name: String, profileUrl: String, uuid: String, lastMessage: String, timeStamp: UInt) {
        self.name = name
        self.profileUrl = profileUrl
        self.uuid = uuid
        self.lastMessage = lastMessage
        self.timeStamp = timeStamp
    }
    init(name: String, profileUrl: String, uuid: String) {
        self.name = name
        self.profileUrl = profileUrl
        self.uuid = uuid
      
    }
   
    
}
