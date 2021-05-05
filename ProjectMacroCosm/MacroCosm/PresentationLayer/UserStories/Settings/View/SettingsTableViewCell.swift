//
//  SettingsTableViewCell.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

class DialogTableViewCell: UITableViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
    private var animationStartTime = Date()

    let borderView = UIView()
    var backgroundViewSelected = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    @objc private func setSelected(sender: UILongPressGestureRecognizer) {
        guard sender.state != .ended
        else {
            setSelected(false, animated: true)
            return
        }
        
        let point = sender.location(in: superview)
        let isPointInFrame = frame.contains(point)
        if (backgroundViewSelected.alpha != 0) != isPointInFrame {
            setSelected(isPointInFrame, animated: true)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let duration: TimeInterval = 0.6
        let timeSinceStart = Date().timeIntervalSince(animationStartTime) - duration
        if timeSinceStart < 0 {
            backgroundViewSelected.alpha = CGFloat((-timeSinceStart) / duration) * 0.5
        }

        if animated {
            animationStartTime = Date()
            UIView.transition(with: backgroundViewSelected,
                              duration: duration,
                              options: .curveEaseIn) { [ weak self ] in
                self?.backgroundViewSelected.alpha = selected ? 1 : 0
            }
        } else {
            backgroundViewSelected.alpha = selected ? 1 : 0
        }
    }
    
    // MARK: - Public methods
    
    func setContent(_ content: MenuRow) {
        imageView?.image = content.image?.withRenderingMode(.alwaysTemplate)
        textLabel?.text = content.title
        
        let haveImage = content.image != nil
        textLabel?.textColor = haveImage ? R.color.tintColorDark() : R.color.tintColorLight()
        backgroundViewSelected.backgroundColor = (haveImage ? R.color.tintColorDark() : R.color.backgroundLight())?.withAlphaComponent(0.25)
        borderView.backgroundColor = haveImage ? R.color.backgroundLight() : R.color.tintColorDark()
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        layer.masksToBounds = true
        backgroundColor = R.color.backgroundLight()
        imageView?.tintColor = R.color.tintColorDark()
        textLabel?.font = R.font.gilroyRegular(size: 16)
        textLabel?.textColor = R.color.tintColorDark()
        textLabel?.backgroundColor = .clear
        accessoryType = .disclosureIndicator
        imageView?.contentMode = .scaleAspectFit
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(setSelected(sender:)))
        addGestureRecognizer(longPressRecognizer)
        
        let clearView = UIView()
        clearView.backgroundColor = .clear
        selectedBackgroundView = clearView
        
        backgroundView = borderView
        borderView.backgroundColor = backgroundColor
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = R.color.tintColorDark()?.cgColor

        insertSubview(backgroundViewSelected, at: 0)
        backgroundViewSelected.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewSelected.alpha = 0
        backgroundViewSelected.backgroundColor = R.color.main()?.withAlphaComponent(0.25)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundViewSelected.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            backgroundViewSelected.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            backgroundViewSelected.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundViewSelected.leftAnchor.constraint(equalTo: leftAnchor),
            
            borderView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            borderView.rightAnchor.constraint(equalTo: rightAnchor),
            borderView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}

