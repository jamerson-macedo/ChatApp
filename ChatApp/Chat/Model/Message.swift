//
//  Message.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation
struct Message : Hashable{
    let uuid :String
    let text :String
    let isMe:Bool // verifica se sou eu que to mandando ou não
   
}
