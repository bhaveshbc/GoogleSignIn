//
//  ShadowView.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

class ShadowView: UIControl {

    @IBInspectable var cornerRadius: CGFloat = 14 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            setupAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        setupAppearance()
    }
    
    override func layoutSubviews() {
        setupAppearance()
    }

    /// setup View appearance
    private func setupAppearance() {
        let shadowModel = ShadowOptionModel(shadowOffset: CGSize(width: 0.0, height: 0.0), shadowOpacity: 0.9, shadowRadius: 5.0, shadowColor: AppColor.WhiteShadowColor)
        
        let shadowAndCornerOption = ShadowAndCornerRadiousOptionModel(shadowModel: shadowModel, borderModel: nil)
        self.roundedCornerandShadow(option: shadowAndCornerOption, maskedCorners: MaskedCorners.AllCorner, cornerRadius: cornerRadius)
//          roundedCornerandShadowToView(view: self, cornerRadius: cornerRadius, applyShadow: true, shadowColor: AppColor.WhiteShadowColor, shadowOffset: CGSize(width: 0.0, height: 0.0), shadowOpacity: 0.9, shadowRadius: 5.0, maskedCorners: MaskedCorners.AllCorner, applyBorder: false, borderColor: UIColor.clear, borderWidth: 0.0)
    }
}
