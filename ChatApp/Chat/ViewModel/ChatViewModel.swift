//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation
class ChatViewModel : ObservableObject{
    @Published var messages : [Message] = [Message(uuid: UUID().uuidString, text: "oLA", isMe: false),
                                           Message(uuid: UUID().uuidString, text: "oLA", isMe: true),
                                           Message(uuid: UUID().uuidString, text: "Tudo bem ?", isMe: false),
                                           Message(uuid: UUID().uuidString, text: "Sim", isMe: true),
                                           Message(uuid: UUID().uuidString, text: "e voce  ?", isMe: false),
                                           Message(uuid: UUID().uuidString, text: "ok", isMe: true)]
    @Published var text = ""
}
