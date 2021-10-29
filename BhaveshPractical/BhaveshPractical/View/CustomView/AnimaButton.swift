//
//  AnimaButton.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

public enum StopAnimationStyle {
    case normal
    case expand
    case shake
}

class JIGButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFont()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFont()
    }

    func setupFont() {
        
    }
    
}

class JIGYellowButton: JIGButton, CAAnimationDelegate {

    /// change button state based on boolean. the value true indicate button state is Enable.
    @IBInspectable var isEnable: Bool = false {
        didSet {
            self.backgroundColor = isEnable ? AppColor.FilledBtnColor : AppColor.UnFilledBtnColor
        }
    }

    @IBInspectable open var spinnerColor: UIColor = AppColor.TopGradientColor {
        didSet {
            spiner.spinnerColor = spinnerColor
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 14 {
           didSet {
               layer.cornerRadius = cornerRadius
               layer.masksToBounds = cornerRadius > 0
           }
       }

    private lazy var spiner: SpinerLayer = {
        let spiner = SpinerLayer(frame: self.frame)
        self.layer.addSublayer(spiner)
        return spiner
    }()

    private var cachedTitle: String?
    private var cachedImage: UIImage?

    private let springGoEase: CAMediaTimingFunction  = CAMediaTimingFunction(controlPoints: 0.45, -0.36, 0.44, 0.92)
    private let shrinkCurve: CAMediaTimingFunction   = CAMediaTimingFunction(name: .linear)
    private let expandCurve: CAMediaTimingFunction   = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
    private let shrinkDuration: CFTimeInterval      = 0.1

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
//        applayShadow()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
//        applayShadow()
        self.spiner.setToFrame(self.frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
//        applayShadow()
    }
    
    private func applayShadow() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = AppColor.ButtonShadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 7.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    /// setup button appearance
    private func setupAppearance() {
        self.setTitleColor(AppColor.YellowButton.ButtonTitle, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        setupFont()
        spiner.spinnerColor = spinnerColor
        self.clipsToBounds = true
    }

    open func startAnimation() {
        self.isUserInteractionEnabled = false // Disable the user interaction during the animation
        self.cachedTitle = title(for: .normal)  // cache title before animation of spiner
        self.cachedImage = image(for: .normal)  // cache image before animation of spiner

        self.setTitle("", for: .normal)                    // place an empty string as title to display a spiner
        self.setImage(nil, for: .normal)                    // remove the image, if any, before displaying the spinner

        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.layer.cornerRadius = self.frame.height / 2
            // corner radius should be half the height to have a circle corners
        }, completion: { _ -> Void in
            self.shrink()   // reduce the width to be equal to the height in order to have a circle
            self.spiner.animation() // animate spinner
        })
    }

    open func stopAnimation(animationStyle: StopAnimationStyle = .normal, revertAfterDelay delay: TimeInterval = 1.0, completion:(() -> Void)? = nil) {

        let delayToRevert = max(delay, 0.2)

        switch animationStyle {
        case .normal:
            // We return to original state after a delay to give opportunity to custom transition
            DispatchQueue.main.asyncAfter(deadline: .now() + delayToRevert) {
                self.setOriginalState(completion: completion)
            }
        case .shake:
            // We return to original state after a delay to give opportunity to custom transition
            DispatchQueue.main.asyncAfter(deadline: .now() + delayToRevert) {
                self.setOriginalState(completion: nil)
                self.shakeAnimation(completion: completion)
            }
        case .expand:
            self.spiner.stopAnimation() // before animate the expand animation we need to hide the spiner first
            self.expand(completion: completion, revertDelay: delayToRevert) // scale the round button to fill the screen
        }
    }

       private func setOriginalState(completion:(() -> Void)?) {
        self.spiner.stopAnimation()
        self.setTitle(self.cachedTitle, for: .normal)
        self.setImage(self.cachedImage, for: .normal)
        self.layer.cornerRadius = self.cornerRadius
        self.animateToOriginalWidth(completion: completion)
        self.isUserInteractionEnabled = true // enable again the user interaction
       }

       private func animateToOriginalWidth(completion:(() -> Void)?) {
           let shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
           shrinkAnim.fromValue = (self.bounds.height)
           shrinkAnim.toValue = (self.bounds.width)
           shrinkAnim.duration = shrinkDuration
           shrinkAnim.timingFunction = shrinkCurve
           shrinkAnim.fillMode = .forwards
           shrinkAnim.isRemovedOnCompletion = false

           CATransaction.setCompletionBlock {
               completion?()
           }
           self.layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)

           CATransaction.commit()
       }

       private func shrink() {
           let shrinkAnim                   = CABasicAnimation(keyPath: "bounds.size.width")
           shrinkAnim.fromValue             = frame.width
           shrinkAnim.toValue               = frame.height
           shrinkAnim.duration              = shrinkDuration
           shrinkAnim.timingFunction        = shrinkCurve
           shrinkAnim.fillMode              = .forwards
           shrinkAnim.isRemovedOnCompletion = false

           layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
       }

    private func shakeAnimation(completion:(() -> Void)?) {
        let keyFrame = CAKeyframeAnimation(keyPath: "position")
        let point = self.layer.position
        keyFrame.values = [NSValue(cgPoint: CGPoint(x: CGFloat(point.x), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x - 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: CGPoint(x: CGFloat(point.x + 10), y: CGFloat(point.y))),
                           NSValue(cgPoint: point)]

        keyFrame.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        keyFrame.duration = 0.7
        self.layer.position = point

        CATransaction.setCompletionBlock {
            completion?()
        }
        self.layer.add(keyFrame, forKey: keyFrame.keyPath)

        CATransaction.commit()
    }

       private func expand(completion:(() -> Void)?, revertDelay: TimeInterval) {

           let expandAnim = CABasicAnimation(keyPath: "transform.scale")
           let expandScale = (UIScreen.main.bounds.size.height/self.frame.size.height)*2
           expandAnim.fromValue            = 1.0
           expandAnim.toValue              = max(expandScale, 26.0)
           expandAnim.timingFunction       = expandCurve
           expandAnim.duration             = 0.4
           expandAnim.fillMode             = .forwards
           expandAnim.isRemovedOnCompletion  = false

           CATransaction.setCompletionBlock {
               completion?()
               // We return to original state after a delay to give opportunity to custom transition
               DispatchQueue.main.asyncAfter(deadline: .now() + revertDelay) {
                   self.setOriginalState(completion: nil)
                   self.layer.removeAllAnimations() // make sure we remove all animation
               }
           }

           layer.add(expandAnim, forKey: expandAnim.keyPath)

           CATransaction.commit()
       }
}
