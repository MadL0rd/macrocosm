//
//  GeneralView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class GeneralView: UIView {
    
    let refreshControl = UIActivityIndicatorView(style: .whiteLarge)
    
    let scroll = UIScrollView()

    let imageView = UIImageView()
    let zodiacNameStack = UIStackView()
    let zodiacNameLabel = UILabel()
    let zodiacInfoTextLabel = UILabel()
    let predictionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    // MARK: - Public methods
    
    func setLoadingState(isActive: Bool, animated: Bool = true) {
        if isActive {
            refreshControl.startAnimating()
        } else {
            refreshControl.stopAnimating()
        }
        if animated {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.scroll.alpha = isActive ? 0 : 1
            }
        } else {
            scroll.alpha = isActive ? 0 : 1
        }
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        
        setupScroll()
        setupContentViews()
                
        makeConstraints()
    }
    
    private func setupScroll() {
        addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        
        addSubview(refreshControl)
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.color = R.color.tintColorDark()
    }
    
    private func setupContentViews() {
        scroll.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        scroll.addSubview(zodiacNameStack)
        zodiacNameStack.translatesAutoresizingMaskIntoConstraints = false
        zodiacNameStack.axis = .vertical
        
        zodiacNameStack.addArrangedSubview(zodiacNameLabel)
        zodiacNameLabel.translatesAutoresizingMaskIntoConstraints = false
        zodiacNameLabel.textColor = R.color.tintColorDark()
        zodiacNameLabel.font = R.font.westlake(size: 16)
        zodiacNameLabel.numberOfLines = 0
        zodiacNameLabel.textAlignment = .left
        
        zodiacNameStack.addArrangedSubview(zodiacInfoTextLabel)
        zodiacInfoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        zodiacInfoTextLabel.textColor = R.color.tintColorDark()
        zodiacInfoTextLabel.font = R.font.gilroyLight(size: 12)
        zodiacInfoTextLabel.numberOfLines = 3
        zodiacInfoTextLabel.textAlignment = .left
        
        scroll.addSubview(predictionLabel)
        predictionLabel.translatesAutoresizingMaskIntoConstraints = false
        predictionLabel.textColor = R.color.tintColorDark()
        predictionLabel.font = R.font.gilroyLight(size: 12)
        predictionLabel.numberOfLines = 0
        predictionLabel.textAlignment = .left
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            refreshControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshControl.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.centerXAnchor.constraint(equalTo: centerXAnchor),
            scroll.widthAnchor.constraint(equalTo: widthAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            imageView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            zodiacNameStack.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            zodiacNameStack.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 24),
            zodiacNameStack.widthAnchor.constraint(equalToConstant: UIConstants.screenBounds.width - 120),
            
            predictionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            predictionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            predictionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36),
            predictionLabel.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])
    }
}
