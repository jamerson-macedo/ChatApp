//
//  ContactsUiState.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 26/07/24.
//

import Foundation

enum ContactsUiState : Equatable{
    case loading
    case none
    case error(String)
    case success
}
