//
//  FloatingTextField.swift
//  BhaveshPractical
//
//  Created by Bhavesh Chaudhari on 29/10/21.
//

import UIKit

@IBDesignable

/// The Custom textFiled used in entire Application.it is IBDesignable so it can be used on storyboard Also.
open class FloatingTextField: UITextField {

   private var labelPlaceholderTitleTop: NSLayoutConstraint!
   private var labelPlaceholderTitleCenterY: NSLayoutConstraint!
   private var labelPlaceholderTitleLeft: NSLayoutConstraint!
   private var padding = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    private var heightAnchorOfBottomLine: NSLayoutConstraint!

    var allowToShrinkPlaceholderSizeOnEditing = true
    var shrinkSizeOfPlaceholder: CGFloat = 0

    /// The Button used for secure password textField.ex : the eyeIcon.
    let preview: UIButton = {
       let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "ic_visibility"), for: .normal)
//        button.addTarget(self, action: #selector(SSTextField.buttonTapped(sender:)), for: .touchUpInside)
        return button
    }()

    /// The Boolean used to  set textFiled state for Password.
    @IBInspectable var isForPassword: Bool = false {
        didSet {
            if isForPassword {
//                padding.right = 60
                self.isSecureTextEntry = true
//                self.rightView = preview
//                self.rightViewMode = .always
            }
        }
    }

    var isValidate: Bool = false {
        didSet {
            if isValidate {
                setNormalState()
            } else {
                setErrorState()
            }
        }
    }

    private func setErrorState() {
        labelPlaceholderTitle.textColor = .red
        self.layer.borderColor = UIColor.red.cgColor
    }

    private func setNormalState() {
        labelPlaceholderTitle.textColor = AppColor.floatPlaceholderActiveColor
        self.layer.borderColor = UIColor.lightGray.cgColor
    }

    /// The Custom placeholder for textFiled.
    lazy var labelPlaceholderTitle: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = self.font
//            label.setupFont()
           label.adjustsFontSizeToFitWidth = true
            label.textColor = AppColor.floatPlaceholderActiveColor
           return label
       }()

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewBound = super.rightViewRect(forBounds: bounds)
        rightViewBound.origin.x = self.frame.width - 50
        return rightViewBound
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetup()
    }

    override open func prepareForInterfaceBuilder() {
        self.initialSetup()
    }

    /// customize preview of textFiled.ex: set custom Font,Font size,color etc.this function also customize preview of labelPlaceholderLabel
    func initialSetup() {
//        if UIScreen.main.traitCollection ==
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        setupFont()
        self.labelPlaceholderTitle.text = placeholder
        placeholder = nil
        borderStyle = .none
        self.layer.cornerRadius = 9.6
//        self.layer.borderColor = SSColor.textFiledBorder?.cgColor
//        self.layer.borderWidth = 1
        self.autocorrectionType = .no
        preview.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
        addSubview(labelPlaceholderTitle)
        labelPlaceholderTitleLeft = labelPlaceholderTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: padding.left)
        labelPlaceholderTitleLeft.isActive = true
        labelPlaceholderTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        labelPlaceholderTitleTop = labelPlaceholderTitle.topAnchor.constraint(equalTo: topAnchor, constant: padding.top)
        labelPlaceholderTitleTop.isActive = false
        labelPlaceholderTitleCenterY = labelPlaceholderTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        labelPlaceholderTitleCenterY.isActive = true
        labelPlaceholderTitleLeft.constant = padding.left
        if text != "" {
            self.textFieldDidChange()
        }
        addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }

    /// action handler for preview Button
    /// - Parameter sender: preview Button
    @objc func buttonTapped(sender: UIButton) {
            self.isSecureTextEntry.toggle()
            let passwordImage = self.isSecureTextEntry ? UIImage(named: "ic_visibility") : UIImage(named: "ic_visibility_off")
                  self.preview.setImage(passwordImage, for: .normal)
    }

    @objc func textFieldDidChange() {
        if !self.isValidate {
            self.isValidate = true
        }

//        self.labelPlaceholderTitle.text = self.placeholder

        func animateLabel() {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }

        if let enteredText = text, enteredText != "" {
            if labelPlaceholderTitleCenterY.isActive {
                labelPlaceholderTitleCenterY.isActive = false
                labelPlaceholderTitleTop.isActive = true
                labelPlaceholderTitleTop.constant = 6
                if allowToShrinkPlaceholderSizeOnEditing {
                    let currentFont = font == nil ? UIFont.systemFont(ofSize: 16, weight: .semibold) : font!
                    let shrinkSize = shrinkSizeOfPlaceholder == 0 ? currentFont.pointSize-4 : shrinkSizeOfPlaceholder
                    labelPlaceholderTitle.font = UIFont.init(descriptor: currentFont.fontDescriptor, size: shrinkSize)
                }
                padding.bottom = -10
                animateLabel()
            }
        } else {
            labelPlaceholderTitleCenterY.isActive = true
            labelPlaceholderTitleTop.isActive = false
            labelPlaceholderTitleTop.constant = 0
            labelPlaceholderTitle.font = font
            padding.bottom = 10
            animateLabel()
        }
    }
}
