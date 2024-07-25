//
//  ContactView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct ContactView: View {
    var contact:Contacts
    var body: some View {
        HStack(){
       
            AsyncImage(url:URL(string: contact.profileUrl)){ img in
                img.resizable().clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50,height: 50)
            Text(contact.name)
            Spacer()
            
        }
    }
}

#Preview {
    ContactView(contact: Contacts(name: "jamerson macedo", profileUrl: "https://firebasestorage.googleapis.com:443/v0/b/chatapp-e5dfd.appspot.com/o/images%2F95230E3C-3C0D-4377-BD70-835308313597.jpg?alt=media&token=af071eb0-9ae5-4ac1-993f-d61347f2d5b9"
, uuid: "1"))
}
