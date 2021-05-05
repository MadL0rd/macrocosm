//
//  UserInfoEditorView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class UserInfoEditorView: UIView {
    
    let scroll = UIScrollView()
    let stack = UIStackView()
    let dateButton = ButtonWithTouchSize()
    let timeButton = ButtonWithTouchSize()
    let locationButton = ButtonWithTouchSize()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Public methods
    
    func setTitleToButton(button: ButtonWithTouchSize, title: String) {
        UIView.transition(with: button,
                          duration: 0.3,
                          options: [.transitionCrossDissolve]) {
            button.setTitle(title, for: .normal)
        }
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        
        setupScrollAndMainStack()
        
        UIStyleManager.darkButton(dateButton)
        dateButton.setTitle(R.string.localizable.date(), for: .normal)
        setupButtonWithTitle(button: dateButton, title: R.string.localizable.birthDayQuestion())
        
        UIStyleManager.lightButton(timeButton)
        timeButton.setTitle(R.string.localizable.time(), for: .normal)
        setupButtonWithTitle(button: timeButton, title: R.string.localizable.birthTimeQuestion())
        
        UIStyleManager.lightButton(locationButton)
        locationButton.setTitle(R.string.localizable.city(), for: .normal)
        setupButtonWithTitle(button: locationButton, title: R.string.localizable.birthPlaceQuestion())
                
        makeConstraints()
    }
    
    private func setupScrollAndMainStack() {
        addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        scroll.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 43
    }
    
    private func setupButtonWithTitle(button: ButtonWithTouchSize, title: String) {
        let substack = UIStackView()
        stack.addArrangedSubview(substack)
        substack.axis = .vertical
        substack.spacing = 18
        
        let label = UILabel()
        substack.addArrangedSubview(label)
        label.font = R.font.gilroyLight(size: 16)
        label.text = title
        label.textColor = R.color.tintColorDark()
        label.textAlignment = .left
        label.numberOfLines = 0
        
        substack.addArrangedSubview(button)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.centerXAnchor.constraint(equalTo: centerXAnchor),
            scroll.widthAnchor.constraint(equalTo: widthAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 26),
            stack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            stack.widthAnchor.constraint(equalTo: widthAnchor, constant: -36),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -26)
        ])
    }
}
