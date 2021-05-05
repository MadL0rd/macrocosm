//
//  UIStyleManager.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

class UIStyleManager {
    
    // MARK: - UIBarButtonItem
    
    static func setUIBarButtonItemsClear() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear],
                                                            for: .focused)
    }
    
    static func setUIBarButtonItemsDefault() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!],
                                                            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!],
                                                            for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!],
                                                            for: .focused)
    }
    
    // MARK: - UIView
    
    static func textDefaultInput(_ view: UIView, addHeightConstraint: Bool = true) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = R.color.tintColorDark()?.cgColor

        guard addHeightConstraint
        else { return }
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    static func shadow(_ view: UIView) {
        view.layer.shadowColor = R.color.gray()?.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    // MARK: - UINavigationController
    
    static func navigationControllerTransparent(_ controller: UINavigationController) {
        controller.view.backgroundColor = .clear
        controller.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationBar.shadowImage = UIImage()
        controller.navigationBar.isTranslucent = true
        
        controller.navigationBar.tintColor = R.color.tintColorDark()
        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: R.font.westlake(size: 16)!,
                                                        NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!]
    }
    
    // MARK: - UITextField
    
    static func textFieldDefault(textField: UITextField, placeholderText: String) {
        textDefaultInput(textField)
        textField.font = R.font.gilroyBold(size: 14)
        textField.setLeftPaddingPoints(24)
        textField.setRightPaddingPoints(24)

        let attributes = [
            NSAttributedString.Key.foregroundColor: R.color.gray()!,
            NSAttributedString.Key.font: R.font.gilroyRegular(size: 14)!
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: attributes)
    }
    
    // MARK: - Buttons
    
    static func darkButton(_ button: ButtonWithTouchSize) {
        UIStyleManager.textDefaultInput(button)
        button.backgroundColor = R.color.tintColorDark()
        
        button.titleLabel?.font = R.font.gilroyRegular(size: 16)
        button.setTitleColor(R.color.tintColorLight(), for: .normal)
        button.setTitleColor(R.color.tintColorLight(), for: .selected)
        button.titleLabel?.textAlignment = .left
    }
    
    static func lightButton(_ button: ButtonWithTouchSize) {
        UIStyleManager.textDefaultInput(button)
        button.backgroundColor = R.color.tintColorLight()
        
        button.titleLabel?.font = R.font.gilroyRegular(size: 16)
        button.setTitleColor(R.color.tintColorDark(), for: .normal)
        button.setTitleColor(R.color.tintColorDark(), for: .selected)
        button.titleLabel?.textAlignment = .left
    }
}
