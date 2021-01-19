//
//  LoginViewModel.swift
//  FirestoreChat
//
//  Created by Muhammad Ario Bagus on 19/01/21.
//

import Foundation

protocol IAuthentication {
    var formIsValid : Bool {get}
    
}

struct LoginViewModel : IAuthentication {
    
    var email : String?
    var password : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
