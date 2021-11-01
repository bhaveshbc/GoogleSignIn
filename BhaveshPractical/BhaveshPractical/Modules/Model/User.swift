//
//  User.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import Foundation
enum UserDefaultsKey: String {
    case userDetail
}

struct User: Codable {
    
    let name: String
    let emailId: String
    let profilePic: URL
    var longtitude: Double
    var latitude: Double
    
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
        return ["name": name, "emailId": emailId, "profilePic": profilePic.absoluteString, "longtitude": longtitude, "latitude": latitude]
    }
    
    func saveLoggedUserToUserDefault(encoder: JSONEncoder = JSONEncoder()) throws {
        do {
            let encoded = try encoder.encode(self)
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKey.userDetail.rawValue)
        } catch {
            throw error
        }
    }
    
}
