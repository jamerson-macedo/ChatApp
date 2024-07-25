//
//  ContentView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewmodel :ContentViewModel
    
    var body: some View {
        ZStack{
            if viewmodel.isLogged{
               HomeView()
            }else {
                // signin view
                SignInView()
            }
        }.onAppear{
            viewmodel.onAppear()
        }
    }
}

#Preview {
    ContentView(viewmodel: ContentViewModel())
}
