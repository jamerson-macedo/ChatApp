//
//  HomeView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 3 // valor padrão
    @State private var selectedTab : Int = 0

    var body: some View {
        
        TabView(selection:$selection){
            Text("Atualizações")
                .tabItem {
                    VStack{
                        Image(systemName: "circle.fill").environment(\.symbolVariants,selectedTab == 0 ? .fill : .none)
                        Text("Atualizações")
                    }.onAppear{
                        selectedTab = 0
                    }
                }
                .tag(0)
            Text("LIGAÇÕES").tabItem { Label("Ligações", systemImage: "phone") }.tag(1)
            Text("Ferramentas").tabItem { Label("Ferramentas", systemImage: "house") }.tag(2)
            
            MessagesView().tabItem { Label("Conversas", systemImage:
                                            "bubble.left.and.bubble.right") }.tag(3)
            
            ConfigsView().tabItem { Label("Configurações", systemImage: "gear") }.tag(4)
        }
    }
}

#Preview {
    HomeView()
}
