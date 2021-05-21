//
//  PredictionTableViewCell.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import UIKit

class PredictionTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let paragraphLabel = UILabel()
    
    static var identifier: String {
        String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func setContent(_ content: PredictionBlock) {
        titleLabel.text = content.header
        paragraphLabel.text = content.text
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        backgroundColor = R.color.backgroundLight()
        selectedBackgroundView = UIView()
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = R.font.westlake(size: 16)
        titleLabel.textColor = R.color.tintColorDark()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        addSubview(paragraphLabel)
        paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
        paragraphLabel.font = R.font.gilroyLight(size: 12)
        paragraphLabel.textColor = R.color.tintColorDark()
        paragraphLabel.textAlignment = .center
        paragraphLabel.numberOfLines = 0
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: UIConstants.screenBounds.width - 36),
            
            paragraphLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            paragraphLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            paragraphLabel.widthAnchor.constraint(equalToConstant: UIConstants.screenBounds.width - 36),
            paragraphLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

