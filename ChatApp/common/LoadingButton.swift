//
//  LoadingButton.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 22/07/24.
//

import SwiftUI

struct LoadingButton: View {
        
        var action : () -> Void
        var disabled : Bool = false
        var showProgress : Bool = false
        var text: String
        var body: some View {
            ZStack{
                Button(action: {
                    action()
                }, label: {
                    Text(showProgress ? "" : text )
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding(.vertical,14)
                        .padding(.horizontal,16)
                        .font(Font.system(.title3).bold())
                        .background(disabled ? Color("buttom") : Color.green)
                        .foregroundStyle(.white)
                        .cornerRadius(4.0)
                        
                }).disabled(disabled || showProgress)
                
                ProgressView().progressViewStyle(CircularProgressViewStyle()).opacity(showProgress ? 1 : 0)
            }
        }
    }
#Preview {
    LoadingButton( action: {}, disabled: true, text: "Entrar")
}
