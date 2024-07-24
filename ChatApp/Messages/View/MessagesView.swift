//
//  MessagesView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct MessagesView: View {
    @StateObject var viewmodel = MessagesViewModel()
    var body: some View {
        Button("Logout"){
            viewmodel.logout()
        }
    }
}

#Preview {
    MessagesView(viewmodel: MessagesViewModel())
}
