//
//  UIViewControllerUtility.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

extension UIViewController {

    /// initialise viewController with given frame and view instance.
    /// - Parameter view: object of UIView
    /// - Parameter frame: CGRect that will apply to view frame
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
               view.frame = frame
               let controller = UIViewController()
               controller.view = view
               return controller
           }

    /// used to get viewController storyboard-Id based on viewController type.
    class var storyboardID: String {
        return "\(self)"
    }

    /// initialise ViewController from given Storyboard.
    /// - Parameter appStoryboard: instance of Storyboard
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }

    func showError(with error: Error) {
        if let localizedError = error  as? LocalizedError, let errorDescription = localizedError.errorDescription {
            showAlertMessage(viewController: self, messageStr: errorDescription, then: nil)
        } else {
            showAlertMessage(viewController: self, messageStr: error.localizedDescription, then: nil)
        }
    }
    
    func showSpinner() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func hideSpinner() {
        self.children.forEach {
            if $0 is SpinnerViewController {
                $0.willMove(toParent: nil)
                $0.view.removeFromSuperview()
                $0.removeFromParent()
            }
        }
    }

    func addChildController(_ child: UIViewController, frame: CGRect? = nil, containerView: UIView? = nil) {
        addChild(child)

        if let containerView = containerView {
            child.view.frame = containerView.bounds
            containerView.addSubview(child.view)
        } else {
            child.view.frame = self.view.bounds
            view.addSubview(child.view)
        }
        child.didMove(toParent: self)
        if let frame = frame {
            child.view.frame = frame
        }

    }

    func removeChildController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}

func showAlertMessage(viewController: UIViewController, messageStr: String, then handler:  (() -> Void)? = nil) {
    let alertController = UIAlertController(title: "Demo", message: messageStr, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
        if handler != nil {
            handler!()
        }
    })
    alertController.view.tintColor = AppColor.TopGradientColor
    DispatchQueue.main.async {
        alertController.addAction(OKAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
