//
//  GoogleSignInService.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import Foundation
import Firebase
import GoogleSignIn
import UIKit

protocol GoogleSignInServiceProtocol {
    var signInConfig: GIDConfiguration { get }
    func signInwith(controller: UIViewController, compltion: @escaping (Result<User, Error>) -> Void)
    func logout()
}

class GoogleSignInService: GoogleSignInServiceProtocol {
    
    private let token: String
    var signInConfig: GIDConfiguration {
        GIDConfiguration.init(clientID: token)
    }
    
    init(token: String) {
        self.token = token
    }
    
    func signInwith(controller: UIViewController, compltion: @escaping (Result<User, Error>) -> Void) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: controller) { user, error in
            if let error = error {
                compltion(.failure(error))
            } else {
                guard let name = user?.profile?.givenName, let email = user?.profile?.email, let profilePic =  user?.profile?.imageURL(withDimension: 320)  else {
                    return
                }
                
                let userModel = User(name: name, emailId: email, profilePic: profilePic)
                
                compltion(.success(userModel))
            }
        }

    }
    
    func logout() {
        GIDSignIn.sharedInstance.signOut()
    }
}
