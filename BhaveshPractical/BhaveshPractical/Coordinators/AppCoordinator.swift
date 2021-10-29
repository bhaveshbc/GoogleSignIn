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
        let loginController = LoginViewController.instantiate(fromAppStoryboard: .main)
        loginController.coordinator = self
        self.navigationController?.pushViewController(loginController, animated: true)
        currentWindow.rootViewController = self.navigationController
        currentWindow.makeKeyAndVisible()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}
