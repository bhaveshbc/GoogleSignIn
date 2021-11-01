//
//  User.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import Foundation

struct User {
    
    let name: String
    let emailId: String
    let profilePic: URL
    var longtitude: Double
    var latitude: Double
    
    var firebaseManager: FireStoreService?
    
    init(name: String, emailId: String, profilePic: URL) {
        self.name = name
        self.emailId = emailId
        self.profilePic = profilePic
        latitude = 0.0
        longtitude = 0.0
    }
    
    mutating func update(latitude: Double, longtidude: Double) {
        self.longtitude = longtidude
        self.latitude = latitude
    }
    
    func getDict() -> [String: Any] {
        return ["name": name, "emailId": emailId, "profilePic":profilePic.absoluteString, "longtitude": longtitude, "latitude": latitude]
    }
    
}
