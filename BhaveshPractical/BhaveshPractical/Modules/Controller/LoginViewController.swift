//
//  LoginViewController.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit
import Firebase
import GoogleSignIn
class LoginViewController: UIViewController {
    
    @IBOutlet var signInbutton: UIButton!
    
    weak var coordinator: AppCoordinator?
    var googleSignInService: GoogleSignInServiceProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance.signOut()
        googleSignInService = GoogleSignInService(token: "1059491310160-3hlolmgjb74kob5da09cv0een2fi66e0.apps.googleusercontent.com")
        signInbutton.layer.cornerRadius = 17
    }
    
    @IBAction func loginClick(sender: UIButton) {
        googleSignInService?.signInwith(controller: self, compltion: { [weak self] result in
            switch result {
            case .success(let user):
                self?.coordinator?.moveToSignupViewController(user: user, signInService: self?.googleSignInService)
            case .failure(let error):
                print(error)
            }
        })
    }
}
