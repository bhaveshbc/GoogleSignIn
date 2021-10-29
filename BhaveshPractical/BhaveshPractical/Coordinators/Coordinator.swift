//
//  Coordinator.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 28/10/21.
//

import UIKit

@objc protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    @objc optional var navigationController: UINavigationController? {get set}
    func childDidFinish(_ child: Coordinator?)
    func start()
}
