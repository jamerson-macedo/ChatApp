//
//  HomeView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 3 // valor padrão

    var body: some View {
        
        TabView(selection:$selection){
            Text("Atualizações").tabItem { Label("Atualizações", systemImage: "circle.square") }.tag(0)
            Text("LIGAÇÕES").tabItem { Label("Ligações", systemImage: "phone") }.tag(1)
            Text("Ferramentas").tabItem { Label("Ferramentas", systemImage: "house") }.tag(2)
            
            MessagesView().tabItem { Label("Atualizações", systemImage:
                                            "bubble.left.and.bubble.right") }.tag(3)
            
            ConfigsView().tabItem { Label("Configurações", systemImage: "gear") }.tag(4)
        }
    }
}

#Preview {
    HomeView()
}
