//
//  AnnouncementViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

class AnnouncementViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.backgroundLight()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.font = R.font.gilroyBold(size: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.tintColorDark()
        label.text = R.string.localizable.announcementText()
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
}
