//
//  ChatView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import SwiftUI

struct ChatView: View {
    let username : String
    @StateObject var viewmodel = ChatViewModel()
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                ForEach(viewmodel.messages, id: \.self){ message in
                    MessageRow(message: message)
                    
                }
            }
            Spacer()
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus").padding(.horizontal)
                    
                })
                
                TextField("Digite a mensagem",text: $viewmodel.text).autocapitalization(.none)
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .overlay{
                        RoundedRectangle(cornerRadius: 20.0).strokeBorder(Color(UIColor.separator))
                    }
                if(!viewmodel.text.isEmpty){
                    Button(action: {}, label: {
                        
                        Text("Enviar").background(Color.blue)
                            .foregroundColor(Color.white).cornerRadius(10).padding(.trailing)
                    })
                    
                }else{
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "camera")
                        
                        
                    })
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person").padding(.trailing,15)
                        
                    })
                }
                
            }.padding(.horizontal,5)
        }.navigationTitle(username)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    ChatView(username: "JAMERSON")
}
