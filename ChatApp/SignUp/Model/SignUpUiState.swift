//
//  SignUpUiState.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 19/07/24.
//

import Foundation
enum SignUpUiState : Equatable{
    case loading
    case none
    case error(String)
    case success
}
