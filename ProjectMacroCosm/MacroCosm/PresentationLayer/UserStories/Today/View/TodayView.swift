//
//  TodayView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class TodayView: UIView {
    
    let refreshControl = UIActivityIndicatorView(style: .whiteLarge)
    
    let scroll = UIScrollView()

    let imageView = UIImageView()
    let infoLabel = UILabel()
    let line = HorizontalLine()
    
    let predictionsTableView = ContentFittingTableView()
    let footer = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))

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
        
        scroll.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.textColor = R.color.tintColorDark()
        infoLabel.font = R.font.gilroyLight(size: 12)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        
        scroll.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = R.color.tintColorDark()
        line.lineThickness = 2
        
        scroll.addSubview(predictionsTableView)
        predictionsTableView.translatesAutoresizingMaskIntoConstraints = false
        predictionsTableView.isScrollEnabled = false
        predictionsTableView.separatorStyle = .none
        predictionsTableView.backgroundColor = R.color.backgroundLight()
        predictionsTableView.tableFooterView = footer
        predictionsTableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        predictionsTableView.showsVerticalScrollIndicator = false
        predictionsTableView.estimatedRowHeight = 160
        predictionsTableView.rowHeight = UITableView.automaticDimension
        predictionsTableView.register(PredictionTableViewCell.self,
                                      forCellReuseIdentifier: PredictionTableViewCell.identifier)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            refreshControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshControl.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            
            scroll.topAnchor.constraint(equalTo: topAnchor),
            scroll.centerXAnchor.constraint(equalTo: centerXAnchor),
            scroll.widthAnchor.constraint(equalTo: widthAnchor),
            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 36),
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 36),
            infoLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36),
            
            line.centerXAnchor.constraint(equalTo: centerXAnchor),
            line.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30),
            line.widthAnchor.constraint(equalToConstant: 170),
            
            predictionsTableView.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            predictionsTableView.widthAnchor.constraint(equalTo: widthAnchor),
            predictionsTableView.topAnchor.constraint(equalTo: line.bottomAnchor),
            predictionsTableView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])
    }
}
