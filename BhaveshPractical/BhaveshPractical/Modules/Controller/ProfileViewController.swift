//
//  ProfileViewController.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    @IBOutlet var userProfile: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var longtitude: UILabel!
    @IBOutlet var latitude: UILabel!
    
    var loggedUser: User?
    var googleSignInService: GoogleSignInServiceProtocol!
    var locationManager: LocationManagerService?
    var firebaseManager: FireStoreService?
    weak var coordinator: AppCoordinator?
    var imageDonwloader = ImageDownloader()
    private var cancellables: Set<AnyCancellable> = []
    
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
        imageDonwloader.$userIMage.assign(to: \.image, on: self.userProfile).store(in: &cancellables)
    }
    
    @IBAction func logout(sender: UIButton) {
        googleSignInService.logout()
        coordinator?.goback()
    }
    
}

extension ProfileViewController: LocationManagerDelegate {
    
    func locationUpdate(latitude: Double, longtitude: Double) {
        updateUserLocation(latitude: latitude, longtitude: longtitude)
    }
    
    private func updateUserLocation(latitude: Double, longtitude: Double) {
        
        self.longtitude.text = "\(longtitude)"
        self.latitude.text = "\(latitude)"
        guard var loggedUser = loggedUser else {
            return
        }
        
        loggedUser.update(latitude: latitude, longtidude: longtitude)
        
        firebaseManager?.addUser(user: loggedUser, compltion: { [weak self] error in
            if let error = error {
                self?.showError(with: error)
            }
        })
    }
}
