//
//  FireStoreService.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 31/10/21.
//

import Foundation
import Firebase

class FireStoreService {
    
    let dbStore = Firestore.firestore()
    
    func getUser(compltion: @escaping (Result<[User], Error>) -> Void) {
        dbStore.collection("Users").getDocuments { quesrySnapshot, error in
            if let error = error {
                compltion(.failure(error))
            } else {
                var users = [User]()
                if let snapShot = quesrySnapshot {
                    for document in snapShot.documents {
                        if let user = self.convertSnapshot(document: document) {
                            users.append(user)
                        }
                    }
                }
                compltion(.success(users))
            }
        }
    }
    
    private func convertSnapshot(document: QueryDocumentSnapshot) -> User? {
        guard let name = document.data()["name"] as? String else {
            return nil
        }
        
        guard let email = document.data()["email"] as? String else {
            return nil
        }
        
        guard let profilepic = document.data()["profilePic"] as? String, let url = URL(string: profilepic) else {
            return nil
        }
        
        return User(name: name, emailId: email, profilePic: url)
    }
    
    func addUser(user: User, compltion: @escaping (Error?) -> Void) {
        dbStore.collection("Users").document(user.emailId).setData(user.getDict()) { error in
            compltion(error)
        }
    }
    
}
