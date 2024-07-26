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
        VStack(alignment: message.isMe ? . trailing: .leading){
            Text(message.text)
                
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                

               
                
                //.padding(.leading, message.isMe ? 0 : 20)
                //.padding(.trailing, message.isMe ? 20 : 0)
                //.padding(.vertical, 5)
        }
        .background(Color("messageColor"))
        .frame(maxWidth: .infinity,alignment: message.isMe ? . trailing: .leading)
        .padding(.vertical,2)
        .padding(.horizontal,10)
        

    }
}

#Preview {
  
    

    MessageRow(message: Message(uuid: UUID().uuidString, text: "fnwefnjwenfejwf", isMe: true))
}
