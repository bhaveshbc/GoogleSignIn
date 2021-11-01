//
//  ProfileViewController.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!
    
    var loggedUser: User?
    var googleSignInService: GoogleSignInServiceProtocol!
    var locationManager: LocationManagerService?
    var firebaseManager: FireStoreService?
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let loggedUser = loggedUser else {
            return
        }
        firebaseManager = FireStoreService()
        userProfile.layer.cornerRadius = userProfile.bounds.height/2
        setupScreen(user: loggedUser)
        locationManager = LocationManagerService()
        locationManager?.delegate = self
        locationManager?.getUserLocation()
    }
    
    private func setupScreen(user: User) {
        userName.text = user.name
        userEmail.text = user.emailId
        downloadImage(from: user.profilePic)
    }
    
    @IBAction func logout(sender: UIButton) {
        googleSignInService.logout()
        coordinator?.goback()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.userProfile.image = UIImage(data: data)
            }
        }
    }
}

extension ProfileViewController: LocationManagerDelegate {
    
    func locationUpdate(latitude: Double, longtitude: Double) {
        updateUserLocation(latitude: latitude, longtitude: longtitude)
    }
    
    private func updateUserLocation(latitude: Double, longtitude: Double) {
        
        guard var loggedUser = loggedUser else {
            return
        }
        
        loggedUser.update(latitude: latitude, longtidude: longtitude)
        
        firebaseManager?.addUser(user: loggedUser, compltion: { error in
            print(error)
        })
    }
}
