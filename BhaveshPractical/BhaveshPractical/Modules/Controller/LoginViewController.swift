//
//  LoginViewController.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit
import Firebase
import GoogleSignIn
import Combine
class LoginViewController: UIViewController {
    
    @IBOutlet var signInbutton: UIButton!
    
    weak var coordinator: AppCoordinator?
    var googleSignInService: GoogleSignInServiceProtocol!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance.signOut()
        signInbutton.layer.cornerRadius = 17
        googleSignInService = GoogleSignInService(token: Constant.key)
    }
    
    @IBAction func loginClick(sender: UIButton) {
        showSpinner()
        googleSignInService.signInwith(controller: self).sink { compltion in
            switch compltion {
            case .failure(let error):
                self.showError(with: error)
            case .finished:
                self.hideSpinner()
            }
        } receiveValue: { user in
            self.coordinator?.moveToSignupViewController(user: user, signInService: self.googleSignInService)
        }.store(in: &cancellables)
    }
}
