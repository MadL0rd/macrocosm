//
//  DefaultButton.swift
//  MacroCosm
//
//  Created by Антон Текутов on 21.05.2021.
//

import UIKit

class DefaultButton: ButtonWithTouchSize {
    
    let textLabel = UILabel()
    let arrow = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - UI elements actions

    @objc private func buttonDidTapped() {
        tapAnimation()
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundDark()
        translatesAutoresizingMaskIntoConstraints = false
        setDefaultAreaPadding()
        
        addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = R.font.gilroyRegular(size: 16)
        textLabel.textColor = R.color.tintColorLight()
        
        addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = R.image.arrowLeft()
        arrow.contentMode = .scaleAspectFit
        arrow.transform = .init(rotationAngle: .pi)
        arrow.tintColor = R.color.tintColorLight()
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: textLabel.heightAnchor, constant: 32),
            
            arrow.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrow.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            arrow.widthAnchor.constraint(equalToConstant: 6),
            arrow.heightAnchor.constraint(equalToConstant: 12),
            
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            textLabel.rightAnchor.constraint(equalTo: arrow.leftAnchor, constant: 12)
        ])
    }
}
