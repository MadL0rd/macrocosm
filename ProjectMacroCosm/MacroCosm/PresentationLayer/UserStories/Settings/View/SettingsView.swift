//
//  SettingsView.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class SettingsView: UIView {

    let tableView = UITableView()
    let footer = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    let footerLabel = UILabel()

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
        
        addSubview(tableView)
        tableView.separatorColor = R.color.backgroundLight()
        tableView.backgroundColor = R.color.backgroundLight()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = footer
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 64
        
        setupFooter()
        
        makeConstraints()
    }
    
    private func setupFooter() {
        footer.addSubview(footerLabel)
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        footerLabel.font = R.font.gilroyLight(size: 16)
        footerLabel.textAlignment = .center
        footerLabel.numberOfLines = 0
        footerLabel.textColor = R.color.tintColorDark()
        footerLabel.text = "Version: \(Bundle.main.versionNumber)"
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -18),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 18),
            
            footerLabel.topAnchor.constraint(equalTo: footer.topAnchor, constant: 20),
            footerLabel.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            footerLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.9)
        ])
    }
}
