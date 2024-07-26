//
//  MessagesView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct MessagesView: View {
    @StateObject var viewmodel = MessagesViewModel(repo: MessagesRepository())
    @State var isPresented = false
    @State private var text = ""
    var body: some View {
        NavigationView{
            VStack{
                // viewmodel is loading ?
                List(viewmodel.contacts,id: \.self){contacts in
                    ScrollView{
                        NavigationLink {
                            ChatView(contact: contacts)
                            
                        } label: {
                            ContactMessageRow(contact: contacts)
                        }
                        
                        
                    }
                }
                
                
            }.onAppear{
                viewmodel.handleEnabled(enabled: true)
                viewmodel.getContacts()
            }
            .onDisappear{
                viewmodel.handleEnabled(enabled: false)
            }
            .navigationTitle("ChatApp")
                .searchable(text: $text,prompt: "Pesquisar")
            .toolbar{
                ToolbarItemGroup( placement: .navigationBarTrailing){
                    HStack{
                        NavigationLink("Editar",destination: Text("tela de contatos"))
                        
                        Spacer(minLength: 240)
                        
                        NavigationLink(destination: Text("tela de contatos")){
                            Label("Go to Detail", systemImage: "camera")
                        }
                        Button("", systemImage: "message"){ isPresented.toggle()
                            
                        }.sheet(isPresented: $isPresented, content: {
                            ContactsView()
                        })
                        
                    }
                }
            }
           
        }
    }
}

#Preview {
    MessagesView(viewmodel: MessagesViewModel(repo: MessagesRepository()))
}
