//
//  BottomCurvedView.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

class BottomCurvedView: UIView {

    /// The Boolean used to  set textFiled state for Password.
    @IBInspectable var isLightBackground: Bool = false {
        didSet {
            self.backgroundColor = isLightBackground ? .white : .black
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }

    /// setup View appearance
    private func setupAppearance() {
          self.layer.maskedCorners = MaskedCorners.TopCorner
          self.layer.cornerRadius = 35
          self.layer.masksToBounds = false
    }
}
