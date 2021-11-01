//
//  SpinnerViewController.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 01/11/21.
//

import UIKit

class SpinnerViewController: UIViewController {

     var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spinner.color = UIColor.blue
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
