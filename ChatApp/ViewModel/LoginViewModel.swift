//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Tamirlan Aubakirov on 26.08.2022.
//

import Foundation

protocol AuthenticationProtocol {
    var isFormValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {

    var email: String?
    var password: String?
    
    var isFormValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    
   
}
