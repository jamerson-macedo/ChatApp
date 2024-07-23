//
//  SignInUiState.swift
//  ChatApp
//
//  Created by Jamerson Macedo on 22/07/24.
//

import Foundation
import Foundation
enum SignInUiState : Equatable{
    case loading
    case none
    case error(String)
    case success
}
