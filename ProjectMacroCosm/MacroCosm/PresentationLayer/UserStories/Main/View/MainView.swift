//
//  MainView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class MainView: UIView {
    
    let tabBar = SegmentedTabBar()
    let lineSelectionView = HorizontalLine()
    let line = HorizontalLine()

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
        
        setupTabBar()
        setupMenuSegment()

        makeConstraints()
    }
    
    private func setupTabBar() {
        tabBar.segmentViewMode = .title
        tabBar.tabBar.tintColor = R.color.tintColorDark()
        tabBar.tabBar.unselectedItemTintColor = R.color.tintColorDarkAlpha()
        addSubview(tabBar.view)
        tabBar.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMenuSegment() {
        tabBar.menuSegment.removeFromSuperview()
        addSubview(tabBar.menuSegment)
        tabBar.menuSegment.translatesAutoresizingMaskIntoConstraints = false
        tabBar.menuSegment.backgroundColor = R.color.backgroundLight()
        tabBar.menuSegment.selectionView.backgroundColor = R.color.backgroundLight()
        
        lineSelectionView.backgroundColor = R.color.tintColorDark()
        lineSelectionView.lineThickness = 2
        tabBar.menuSegment.selectionView.addSubview(lineSelectionView)
        
        line.backgroundColor = R.color.tintColorDarkAlpha()
        line.lineThickness = 2
        tabBar.menuSegment.insertSubview(line, at: 0)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tabBar.menuSegment.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tabBar.menuSegment.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            tabBar.menuSegment.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            tabBar.menuSegment.heightAnchor.constraint(equalToConstant: 50),
            
            lineSelectionView.widthAnchor.constraint(equalTo: tabBar.menuSegment.selectionView.widthAnchor),
            lineSelectionView.bottomAnchor.constraint(equalTo: tabBar.menuSegment.selectionView.bottomAnchor),
            lineSelectionView.centerXAnchor.constraint(equalTo: tabBar.menuSegment.selectionView.centerXAnchor),
            
            line.widthAnchor.constraint(equalTo: tabBar.menuSegment.widthAnchor),
            line.bottomAnchor.constraint(equalTo: tabBar.menuSegment.bottomAnchor),
            line.centerXAnchor.constraint(equalTo: tabBar.menuSegment.centerXAnchor),
            
            tabBar.view.topAnchor.constraint(equalTo: tabBar.menuSegment.bottomAnchor),
            tabBar.view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tabBar.view.leftAnchor.constraint(equalTo: leftAnchor),
            tabBar.view.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
