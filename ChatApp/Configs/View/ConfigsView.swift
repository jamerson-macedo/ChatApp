//
//  ConfigsView.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 24/07/24.
//

import SwiftUI

struct ConfigsView: View {
    @StateObject private var viewmodel = ConfigsViewModel()
    var body: some View {
        Button(action: {
            viewmodel.logout()
        }, label: {
            Text("Logout")
        })
    }
}

#Preview {
    ConfigsView()
}
