//
//  UIViewUtility.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

struct MaskedCorners {
    static let AllCorner: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
   
    static let TopCorner: CACornerMask  = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    static let BottomCorner: CACornerMask  = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    static let LeftCorner: CACornerMask  = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    static let RightCorner: CACornerMask  = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    
    static let TopAnBottomRCorner: CACornerMask  = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    static let TopAnBottomLCorner: CACornerMask  = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
}

extension UIView {
    
    func roundedCornerandShadow(option: ShadowAndCornerRadiousOptionModel, maskedCorners: CACornerMask, cornerRadius: CGFloat) {
        
        self.layer.maskedCorners = maskedCorners
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        // set the shadow properties
        
        if let shadow = option.shadowModel {
            self.layer.shadowColor = shadow.shadowColor.cgColor
//            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: shadow.shadowRadius).cgPath
            self.layer.shadowOffset = shadow.shadowOffset
            self.layer.shadowOpacity = shadow.shadowOpacity
            self.layer.shadowRadius = shadow.shadowRadius
        }
        
        if let border = option.borderModel {
            self.layer.borderColor = border.borderColor.cgColor
            self.layer.borderWidth = border.borderWidth
        }
    }
    
    func changeShadowOpacity(shadowOpacity: Float) {
        self.layer.shadowOpacity = shadowOpacity
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

    /// Adds bottom border to the view with given side margins
    ///
    /// - Parameters:
    ///   - color: the border color
    ///   - margins: the left and right margin
    ///   - borderLineSize: the size of the border
    func addBottomBorder(color: UIColor = UIColor.red, margins: CGFloat = 0, borderLineSize: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.addConstraint(NSLayoutConstraint(item: border,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .height,
                                                multiplier: 1, constant: borderLineSize))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1, constant: margins))
        self.addConstraint(NSLayoutConstraint(item: border,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1, constant: margins))
    }
    
    func applyDropShadow(cornerRadious: CGFloat, shadowOffset: CGSize, color: UIColor, opacity: Float) {
        
        let shadowModel = ShadowOptionModel(shadowOffset: shadowOffset, shadowOpacity: opacity, shadowRadius: 5, shadowColor: color)
        
        let shadowAndCornerOption = ShadowAndCornerRadiousOptionModel(shadowModel: shadowModel, borderModel: nil)
        self.roundedCornerandShadow(option: shadowAndCornerOption, maskedCorners: MaskedCorners.AllCorner, cornerRadius: cornerRadious)
    }
}
