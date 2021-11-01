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
import Combine

protocol GoogleSignInServiceProtocol {
    func signInwith(controller: UIViewController) -> Future<User, Error>
    func logout()
}

enum GoogleSignInServiceError: Error {
    case noDataFound
}

extension GoogleSignInServiceError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noDataFound:
            return "user data not found"
        }
    }
}

extension GoogleSignInServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noDataFound:
            return NSLocalizedString(
                "user data not found",
                comment: "Invalid Data"
            )
        }
    }
}

class GoogleSignInService: GoogleSignInServiceProtocol {
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
//    func signInwith(controller: UIViewController, compltion: @escaping (Result<User, Error>) -> Void) {
//        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: controller) { user, error in
//            if let error = error {
//                compltion(.failure(error))
//            } else {
//                guard let name = user?.profile?.givenName, let email = user?.profile?.email, let profilePic =  user?.profile?.imageURL(withDimension: 320)  else {
//                    return
//                }
//
//                let userModel = User(name: name, emailId: email, profilePic: profilePic)
//
//                compltion(.success(userModel))
//            }
//        }
//
//    }
    
    func signInwith(controller: UIViewController) -> Future<User, Error> {
        let signInConfig  = GIDConfiguration.init(clientID: token)
        return Future { promise in
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: controller) { user, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    guard let name = user?.profile?.givenName, let email = user?.profile?.email, let profilePic =  user?.profile?.imageURL(withDimension: 320)  else {
                        promise(.failure(GoogleSignInServiceError.noDataFound))
                        return
                    }
                    
                    let userModel = User(name: name, emailId: email, profilePic: profilePic)
                    
                    promise(.success(userModel))
                }
            }
        }
    }
    
    func logout() {
        GIDSignIn.sharedInstance.signOut()
    }
}
