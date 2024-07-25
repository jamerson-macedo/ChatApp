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
                Button(action: {
                    self.isEditing.toggle()
                }) {
                    Text(isEditing ? "Done" : "Edit")
                        .frame(width: 80, height: 40)
                }
                
                List(viewmodel.contacts,id: \.self,selection:$itemSelection ){ contact in
                    ContactView(contact: contact)
                    
                }
                
                
            }.navigationTitle("Nova conversa")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $search,prompt: "Pesquisar nome ou número")
                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
            
            
            
                .onAppear{
                    viewmodel.getContacts()
                    
                }
            
        }
    }
}

#Preview {
    ContactsView()
}
