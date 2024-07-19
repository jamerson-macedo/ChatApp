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
            SignInView()
        }
    }
}
