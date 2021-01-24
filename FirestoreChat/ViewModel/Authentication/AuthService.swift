//
//  AuthService.swift
//  FirestoreChat
//
//  Created by Muhammad Ario Bagus on 24/01/21.
//

import Firebase
import UIKit

struct RegistrationCredentials {
    let Email : String
    let Password : String
    let Username : String
    let Fullname : String
    let ProfileImage : UIImage
    
}

struct AuthService {
    static let shared = AuthService()
    
    func userLogIn(withEmail email : String, password : String, completion : AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(credential : RegistrationCredentials , completion : ((Error?) -> Void)? ) {
        guard let imageData = credential.ProfileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                completion!(error)
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credential.Email, password: credential.Password) { (result, error) in
                    if let error = error {
                        completion!(error)
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    let data = ["email": credential.Email,
                                "fullname": credential.Fullname,
                                "profileImageUrl": profileImageURL,
                                "username": credential.Username,
                                "uid": uid]  as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
            
        }
    }
}
