//
//  ShadowManager.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

struct ShadowAndCornerRadiousOptionModel {
    let shadowModel: ShadowOptionModel?
    let borderModel: BorderOptionModel?
}

struct ShadowOptionModel {
    let shadowOffset: CGSize
    let shadowOpacity: Float
    let shadowRadius: CGFloat
    let shadowColor: UIColor
    
    static let defaultOption = ShadowOptionModel(shadowOffset: CGSize(width: 0.0, height: 0.0), shadowOpacity: 0.9, shadowRadius: 5.0, shadowColor: AppColor.WhiteShadowColor)
}

struct BorderOptionModel {
    let borderColor: UIColor
    let borderWidth: CGFloat
}
