//
//  AboutUsView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class AboutUsView: UIView {
    
    let stack = UIStackView()
    let textLabel = UILabel()
    let emailLabel = CopyLabelView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        
        let mainText = R.string.localizable.whoWeAre()
        stack.addArrangedSubview(textLabel)
        textLabel.textColor = R.color.tintColorDark()
        textLabel.font = R.font.gilroyLight(size: 16)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        let attributedString = NSMutableAttributedString(string: mainText)
        let range: NSRange = attributedString.mutableString.range(of: R.string.localizable.cherryDev(), options: .caseInsensitive)
        attributedString.addAttribute(NSAttributedString.Key.font, value: R.font.gilroyBold(size: 16)!, range: range)
        textLabel.attributedText = attributedString

        addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.setText(labelText: Contacts.mainContactEmail, copyText: Contacts.mainContactEmail)
        
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.navigationBarHeight + 30),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            
            emailLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 40),
            emailLabel.label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -15)
        ])
    }
}
