//
//  ChatView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import SwiftUI

struct ChatView: View {
    let contact :Contacts
    @StateObject var viewmodel = ChatViewModel(repo: ChatRepository())
    @State var textSize :CGSize = .zero
    @Environment(\.dismiss) private var dismiss
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
                            .padding(.vertical,12)
                            .padding(.leading,44)
                            .padding(.trailing,60)
                            .cornerRadius(24.0)
                            .overlay{
                                RoundedRectangle(cornerRadius: 24.0)
                                    .strokeBorder(Color(UIColor.separator))
                            }.frame(maxHeight: (textSize.height + 38) > 100 ? 100 : textSize.height + 38)
                        HStack{
                            Spacer()
                            Image(systemName: "paperclip").foregroundColor(.blue)
                        }.padding(.trailing,10)
                        
                        
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
                            Image(systemName: "mic.circle.fill").resizable().frame(width: 35,height: 35)
                                .padding(.trailing,15)
                            
                        })
                    }
                    
                }.padding(.horizontal,5)
            }
            
        }
        .toolbar(viewmodel.tabvisibility, for: .tabBar)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                HStack{
                    Button(action: {
                        viewmodel.tabvisibility = .visible
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                        
                    })
                    AsyncImage(url:URL(string: contact.profileUrl)){ img in
                        img.resizable().clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 40,height:40)
                    .padding(.leading, 20)
                    Text(contact.name).bold()
                }
            }
            ToolbarItem(placement:.topBarTrailing){
                HStack{
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "video")
                        
                    })
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "phone")
                        
                    })
                    
                    
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewmodel.onAppear(contact: contact)
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
