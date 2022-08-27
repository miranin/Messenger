//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by Tamirlan Aubakirov on 26.08.2022.
//

import Foundation

struct RegistrationViewModel: AuthenticationProtocol {
    
    var email: String?
    var fullname: String?
    var username: String?
    var password: String?
    
    var isFormValid: Bool {
        return email?.isEmpty == false &&
              fullname?.isEmpty == false &&
              username?.isEmpty == false &&
              password?.isEmpty == false
    }
     
  
    

}
