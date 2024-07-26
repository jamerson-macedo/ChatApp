//
//  ContactsView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct ContactsView: View {
    @StateObject var viewmodel = ContactsViewModel()
    @State private var itemSelection = Set<Contacts>()
    @State var isEditing = false
    @State var search = ""
    var body: some View {
        
        NavigationView{
            VStack{
                
                List(viewmodel.contacts,id: \.self){ contact in
                    NavigationLink(destination: ChatView(username:contact.name)){
                        ContactView(contact: contact)
                    }
                }
                
                
            }.navigationTitle("Nova conversa")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $search,prompt: "Pesquisar nome ou número")
                
            
            
                .onAppear{
                    viewmodel.getContacts()
                    
                }
            
        }
    }
}

#Preview {
    ContactsView()
}
