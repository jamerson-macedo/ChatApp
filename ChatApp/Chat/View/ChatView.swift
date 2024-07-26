//
//  ChatView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import SwiftUI

struct ChatView: View {
    let contact :Contacts
    @StateObject var viewmodel = ChatViewModel()
    @State var textSize :CGSize = .zero
    
    @Namespace var bottomId
    var body: some View {
        VStack{
            ScrollViewReader{ proxy in
                
                ScrollView(showsIndicators: false){
                    Color.clear.id(bottomId)
                    LazyVStack{
                        ForEach(viewmodel.messages, id: \.self){ message in
                            MessageRow(message: message).scaleEffect(x:1.0,y:-1.0, anchor: .center)
                                .onAppear{
                                    if message == viewmodel.messages.last && viewmodel.messages.count >= viewmodel.limit{
                                        viewmodel.onAppear(contact: contact)
                                    }
                                }
                            
                        }
                        // vizualiza se mudou
                        .onChange(of: viewmodel.newCount){ _,newValue in
                            if newValue > viewmodel.messages.count{
                                withAnimation{
                                    proxy.scrollTo(bottomId)
                                }
                            }
                            
                        }.padding(.horizontal,20)
                    }
                    
                }
                .gesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.endEditing()
                })) //verificando os gestos no scrool
                .rotationEffect(Angle(degrees: 180))
                .scaleEffect(x:-1.0,y: 1.0, anchor: .center)
                Spacer()
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus").padding(.horizontal)
                        
                    })
                    ZStack{
                        TextEditor(text: $viewmodel.text)
                            .autocapitalization(.none)
                            .background(Color.white)
                            .padding()
                            .cornerRadius(24.0)
                            .overlay{
                                RoundedRectangle(cornerRadius: 24.0)
                                    .strokeBorder(Color(UIColor.separator))
                            }.frame(maxHeight: (textSize.height + 38) > 100 ? 100 : textSize.height + 38)
                        
                        Text(viewmodel.text)
                            .opacity(0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(ViewGeometry())
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal)
                            .onPreferenceChange(ViewSizeKey.self){ size in
                                textSize = size
                                
                            }
                    }
                    if(!viewmodel.text.isEmpty){
                        Button(action: {
                            
                            viewmodel.sendMessage(contact:contact)
                            
                        }, label: {
                            
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
            }.navigationTitle(contact.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(false)
                .onAppear{
                    viewmodel.onAppear(contact: contact)
                }
        }
        
    }
}
struct ViewGeometry :View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: ViewSizeKey.self, value: geometry.size)
            
        }
    }
}

struct ViewSizeKey : PreferenceKey{
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
    
}

#Preview {
    ChatView(contact: Contacts(name: "Jamerson", profileUrl: "", uuid: UUID().uuidString))
}
