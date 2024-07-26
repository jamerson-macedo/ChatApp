//
//  ContactsView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct ContactsView: View {
    @StateObject var viewmodel = ContactsViewModel(repo: ContactsRepository())
    @State private var itemSelection = Set<Contacts>()
    @State var isEditing = false
    @State var search = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack{
            NavigationStack{
                
                VStack{
                    HStack(spacing: 16){
                        Image(systemName: "person.2")
                        Text("Novo grupo")
                        Spacer()
                    }
                    .padding(.horizontal)
                        .foregroundColor(Color.blue)
                    
                   
                    if case ContactsUiState.loading = viewmodel.uiState{
                        ProgressView()
                    }
                    else if case ContactsUiState.error(let msg) = viewmodel.uiState{
                        
                        Text("")
                            .alert(isPresented: .constant(true)) {
                                Alert(
                                    title: Text("Ops! \(msg)"),
                                    message: Text("Tentar novamente?"),
                                    primaryButton: .default(Text("Sim")) {
                                        // aqui executa a retentativa
                                        viewmodel.getContacts()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        
                        
                        
                    }else {
                        
                        List(viewmodel.contacts,id: \.self){ contact in
                            NavigationLink(destination: ChatView(contact: contact)){
                                ContactView(contact: contact)
                            }
                        }
                    }
                    
                    
                }.navigationTitle("Nova conversa")
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(text: $search,prompt: "Pesquisar nome ou número")
                
                
                
                    .onAppear{
                        viewmodel.getContacts()
                        
                    }
                    .toolbar(content: {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark.circle")
                        })
                       
                    })
                    
                
            }
        }
    }
}

#Preview {
    ContactsView()
}
