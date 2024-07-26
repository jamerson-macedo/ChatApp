//
//  MessageRow.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import SwiftUI

struct MessageRow: View {
    let message : Message
    
    var body: some View {
        
        Text(message.text).background(Color.green).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: message.isMe ? . trailing: .leading)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical : true)
            .padding(.leading, message.isMe ? 0 : 20)
            .padding(.trailing, message.isMe ? 20 : 0)
            .padding(.vertical, 5)
        
    }
}

#Preview {
  
    

    MessageRow(message: Message(uuid: UUID().uuidString, text: "Ola", isMe: true))
}
