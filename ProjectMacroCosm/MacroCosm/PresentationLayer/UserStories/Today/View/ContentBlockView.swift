//
//  ContentBlockView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import UIKit

class ContentBlockView: UIView {
    
    var blurView: UIVisualEffectView!
    let stack = UIStackView()
    let titleLabel = UILabel()
    let textLabel = UILabel()
    let adsWatchButton = DefaultButton()
    let adsDisableButton = DefaultButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .regular)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 0.99
        addSubview(blurView)
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        
        stack.addArrangedSubview(titleLabel)
        titleLabel.text = "⭐️ \(R.string.localizable.contentBlockScreenTitle().uppercased()) ⭐️"
        titleLabel.font = R.font.gilroyBold(size: 14)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = R.color.tintColorDark()
        
        stack.addArrangedSubview(textLabel)
        textLabel.text = R.string.localizable.contentBlockScreenText()
        textLabel.font = R.font.gilroySemibold(size: 14)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.textColor = R.color.tintColorDark()
        
        stack.addArrangedSubview(adsWatchButton)
        adsWatchButton.translatesAutoresizingMaskIntoConstraints = false
        adsWatchButton.textLabel.text = R.string.localizable.contentBlockScreenWatchAdsButton()
        
        stack.addArrangedSubview(adsDisableButton)
        adsDisableButton.translatesAutoresizingMaskIntoConstraints = false
        adsDisableButton.textLabel.text = R.string.localizable.removeAd()
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIConstants.screenBounds.width * 0.15),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            
            titleLabel.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -32),
            textLabel.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -32),
            
            adsWatchButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            adsDisableButton.widthAnchor.constraint(equalTo: stack.widthAnchor)
        ])
    }
}
