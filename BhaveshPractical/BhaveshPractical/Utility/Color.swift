//
//  Color.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import Foundation
import UIKit

struct AppColor {

    private struct Alphas {
        static let Opaque = CGFloat(1)
        static let SemiOpaque = CGFloat(0.8)
        static let SemiTransparent = CGFloat(0.5)
        static let Transparent = CGFloat(0.3)
    }
    
    static let TintColor =  UIColor(red: 59.0/255.0, green: 49.0/255.0, blue: 75.0/255.0, alpha: 1.0)
   
    static let floatPlaceholderActiveColor =  UIColor(red: 196.0/255.0, green: 184.0/255.0, blue: 213.0/255.0, alpha: 1.0)

    static var themeColor: UIColor {
        return UIColor(named: "themeColor") ?? UIColor.blue
    }

    static let shadowColor =  UIColor(red: 30.0/255.0, green: 22.0/255.0, blue: 41.0/255.0, alpha: 0.5)
    static let WhiteShadowColor =  UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.11)
    static let ButtonShadowColor =  UIColor(red: 42.0/255.0, green: 32.0/255.0, blue: 60.0/255.0, alpha: 0.13)
    static let CardShadowColor =  UIColor(red: 30.0/255.0, green: 0.0/255.0, blue: 20.0/255.0, alpha: 0.56)
    
    static let FilledBtnColor = UIColor(hex: "E2A521") ?? UIColor(red: 226.0/255.0, green: 165.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    static let UnFilledBtnColor =  UIColor(hex: "E2A521") ?? UIColor(red: 230.0/255.0, green: 193.0/255.0, blue: 77.0/255.0, alpha: 1.0)
  
    static let RegistrationBGColor = UIColor(red: 30.0/255.0, green: 22.0/255.0, blue: 41.0/255.0, alpha: 1.0)

    static let OTPBorderColor = UIColor(red: 219.0/255.0, green: 183.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    static let BottomGradientColor = UIColor(red: 150.0/255.0, green: 68.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    static let TopGradientColor = UIColor(red: 72.0/255.0, green: 15.0/255.0, blue: 159.0/255.0, alpha: 1.0)
    
    struct TextColors {
//        static let Error = AppColor.appSecondaryColor
        static let Success = UIColor(red: 0.1303, green: 0.9915, blue: 0.0233, alpha: Alphas.Opaque)
    }

    struct TabBarColors {
        static let Selected = UIColor.white
        static let NotSelected = UIColor.black
    }

    struct OverlayColor {
        static let SemiTransparentBlack = UIColor.black.withAlphaComponent(Alphas.Transparent)
        static let SemiOpaque = UIColor.black.withAlphaComponent(Alphas.SemiOpaque)
        static let demoOverlay = UIColor.black.withAlphaComponent(0.6)
    }

    struct YellowButton {
        static var ButtonTitle: UIColor {
               return UIColor(named: "ButtonTitle") ?? UIColor.black
           }
    }
}

extension UIColor {

    // MARK: - Initialization

    convenience init?(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

            if hexFormatted.hasPrefix("#") {
                hexFormatted = String(hexFormatted.dropFirst())
            }

            assert(hexFormatted.count == 6, "Invalid hex code used.")

            var rgbValue: UInt64 = 0
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: 1.0)
    }

    // MARK: - Computed Properties

    var toHex: String? {
        return toHex()
    }

    // MARK: - From UIColor to String

    func toHex(isAlpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }

        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        var alpha = Float(1.0)

        if components.count >= 4 {
            alpha = Float(components[3])
        }

        if isAlpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255), lroundf(alpha * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
        }
    }

}
