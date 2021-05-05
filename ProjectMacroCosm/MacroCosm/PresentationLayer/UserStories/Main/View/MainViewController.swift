//
//  MainViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class MainViewController: UIViewController {

    var viewModel: MainViewModelProtocol!
    var coordinator: MainCoordinatorProtocol!
        
    private var _view: MainView {
        return view as! MainView
    }

    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }
    
    private func configureSelf() {
        navigationItem.title = R.string.localizable.appName()
        navigationController?.navigationBar.tintColor = R.color.tintColorDark()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: R.font.westlake(size: 16)!,
                                                                   NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!]
        
        let settingsButton = UIBarButtonItem(title: R.string.localizable.settings(),
                                             style: .done,
                                             target: self,
                                             action: #selector(openSettings))
        settingsButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.gilroyRegular(size: 12)!,
                                               NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!],
                                              for: .normal)
        settingsButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.gilroyRegular(size: 12)!,
                                               NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!],
                                              for: .selected)
        navigationItem.rightBarButtonItem = settingsButton
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        addChild(_view.tabBar)
        
        var tabBarBuff = [UIViewController]()
        
        var vc = coordinator.generateTodayModule()
        vc.tabBarItem.title = R.string.localizable.today().uppercased()
        tabBarBuff.append(vc)
        
        vc = coordinator.generateGeneralModule()
        vc.tabBarItem.title = R.string.localizable.general().uppercased()
        tabBarBuff.append(vc)
        
        _view.tabBar.setViewControllers(tabBarBuff, animated: false)
    }
    
    @objc private func openSettings() {
        coordinator.openModule(.settings)
    }
}
