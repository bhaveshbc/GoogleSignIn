//
//  AppCoordinator.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 28/10/21.
//

import UIKit

class AppCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    var currentWindow: UIWindow

    init(currentWindow: UIWindow) {
        self.currentWindow = currentWindow
        let rootNavigationController = UINavigationController()
        rootNavigationController.isNavigationBarHidden = true
        self.navigationController = rootNavigationController
    }
    
    func start() {
        if let userdata = UserDefaults.standard.value(forKey: UserDefaultsKey.userDetail.rawValue) as? Data {
            do {
                let user = try JSONDecoder().decode(User.self, from: userdata)
                let  googleSignInService = GoogleSignInService(token: Constant.key)
                moveToSignupViewController(user: user, signInService: googleSignInService, isFirst: true)
            } catch {
                moveTologinController()
            }
        } else {
            moveTologinController()
        }
    }
    
    func moveTologinController() {
        let loginController = LoginViewController.instantiate(fromAppStoryboard: .main)
        loginController.coordinator = self
        self.navigationController?.pushViewController(loginController, animated: true)
        currentWindow.rootViewController = self.navigationController
        currentWindow.makeKeyAndVisible()
    }
    
    func goback() {
        if let loginController = self.navigationController?.viewControllers.first(where: { controller in
            return controller is LoginViewController
        }) {
            self.navigationController?.popToViewController(loginController, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
            moveTologinController()
        }
    }
    
    func moveToSignupViewController(user: User, signInService: GoogleSignInServiceProtocol?, isFirst: Bool = false) {
        let profileViewController = ProfileViewController.instantiate(fromAppStoryboard: .main)
        profileViewController.loggedUser = user
        profileViewController.googleSignInService = signInService
        profileViewController.coordinator = self
        self.navigationController?.pushViewController(profileViewController, animated: true)
        if isFirst {
            currentWindow.rootViewController = self.navigationController
            currentWindow.makeKeyAndVisible()
        }
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}
