//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import SwiftUI
import Firebase

@main
struct ChatApp: App {
    init(){
        FirebaseApp.configure()
    
    }
    var body: some Scene {
        WindowGroup {
            
            ContentView(viewmodel: ContentViewModel())
        }
    }
}
extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
