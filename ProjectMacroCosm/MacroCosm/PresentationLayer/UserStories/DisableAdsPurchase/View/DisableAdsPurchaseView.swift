//
//  DisableAdsPurchaseView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import UIKit

final class DisableAdsPurchaseView: AlertPresentationView {

///    let backgroundView = UIView()
///    let contentView = UIView()
///    var duration: TimeInterval = 0.4
///    var transitionYContentMovingDelta: CGFloat
    
    let stack = UIStackView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let textLabel = UILabel()
    let buyButton = DefaultButton()
    let priceLabel = UILabel()

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
        backgroundView.backgroundColor = R.color.tintColorDark()?.withAlphaComponent(0.5)
        
        contentView.backgroundColor = R.color.backgroundLight()
        
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        
        stack.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.moon()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = R.color.tintColorDark()
        
        stack.addArrangedSubview(titleLabel)
        titleLabel.text = R.string.localizable.adsPurchaseTitle()
        titleLabel.font = R.font.gilroySemibold(size: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = R.color.tintColorDark()
        
        stack.addArrangedSubview(textLabel)
        textLabel.text = R.string.localizable.adsPurchaseText()
        textLabel.font = R.font.gilroyRegular(size: 16)
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.textColor = R.color.tintColorDark()
        
        stack.addArrangedSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.textLabel.text = R.string.localizable.adsPurchaseButtonText()
        
        buyButton.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "..."
        priceLabel.font = R.font.gilroyRegular(size: 16)
        priceLabel.textColor = R.color.tintColorLight()
        
        makeConstraints()
    }

    private func makeConstraints() {
        stack.setCustomSpacing(42, after: imageView)
        stack.setCustomSpacing(12, after: titleLabel)
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -UIConstants.screenBounds.width * 0.15),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, constant: -36),
            
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),

            imageView.widthAnchor.constraint(equalToConstant: 65),
            imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            
            titleLabel.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -32),
            textLabel.widthAnchor.constraint(equalTo: stack.widthAnchor, constant: -32),
            
            buyButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: buyButton.centerYAnchor),
            priceLabel.rightAnchor.constraint(equalTo: buyButton.arrow.leftAnchor, constant: -12)
        ])
    }
}
