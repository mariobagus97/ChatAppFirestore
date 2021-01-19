//
//  RegisterViewModel.swift
//  FirestoreChat
//
//  Created by Muhammad Ario Bagus on 19/01/21.
//

import Foundation

struct RegisterViewModel : IAuthentication {
    var email : String?
    var password : String?
    var username : String?
    var fullname : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            username?.isEmpty == false &&
            fullname?.isEmpty == false
    }
}
