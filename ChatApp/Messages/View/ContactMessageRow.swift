//
//  ContactMessageRow.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import SwiftUI

struct ContactMessageRow: View {
    var contact : Contacts
    var body: some View {
        HStack(){
            
            AsyncImage(url:URL(string: contact.profileUrl)){ img in
                img.resizable().clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50,height: 50)
           
            VStack{
                Text(contact.name).bold()
                if let msg = contact.lastMessage{
                    Text(msg).foregroundStyle(Color.gray)
                }
            }
            Spacer()
            
        }
    }
}

#Preview {
    ContactMessageRow(contact: Contacts(name: "JAMERSON", profileUrl: "", uuid: "1",lastMessage: "E AI MORAL", timeStamp: 12))
}
