//
//  SettingsViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

struct MenuRow {
    let image: UIImage?
    let title: String
    let action: () -> Void
}
struct MenuModule {
    let title: String
    var rows = [MenuRow]()
}

final class SettingsViewController: UIViewController {

    var viewModel: SettingsViewModelProtocol!
    var coordinator: SettingsCoordinatorProtocol!
    
    var menu = [MenuModule]()
        
    private var _view: SettingsView {
        return view as! SettingsView
    }

    override func loadView() {
        self.view = SettingsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        generateBaseMenuModule()
        generateAboutUsMenuModule()
        generateInfoMenuModule()
        
        _view.tableView.dataSource = self
        _view.tableView.delegate = self
        _view.tableView.register(DialogTableViewCell.self, forCellReuseIdentifier: DialogTableViewCell.identifier)
        
        navigationItem.title = R.string.localizable.settings()
        navigationController?.navigationBar.tintColor = R.color.tintColorDark()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: R.font.westlake(size: 16)!,
                                                                   NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!]
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: R.font.gilroyRegular(size: 12)!,
                                                                  NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!], for: .normal)
        navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: R.font.gilroyRegular(size: 12)!,
                                                                  NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!], for: .selected)
    }
    
    private func generateBaseMenuModule() {
        var module = MenuModule(title: "")
        module.rows.append(MenuRow(image: nil,
                                   title: R.string.localizable.changeBirthInformation(),
                                   action: { [ weak self ] in self?.coordinator.openModule(.userInfoEditor) }))
        module.rows.append(MenuRow(image: R.image.removeAd(),
                                   title: R.string.localizable.removeAd(),
                                   action: { [ weak self ] in self?.purchaseCheck() }))
        module.rows.append(MenuRow(image: R.image.settingsSupport(),
                                   title: R.string.localizable.support(),
                                   action: {[ weak self ] in
                                    guard let url = self?.viewModel.supportUrl
                                    else { return }
                                    UIApplication.shared.open(url)
                                   }))
        module.rows.append(MenuRow(image: R.image.settingsRate(),
                                   title: R.string.localizable.rateApp(),
                                   action: { [ weak self ] in self?.viewModel.rateApp() }))
        module.rows.append(MenuRow(image: R.image.settingsRestore(),
                                   title: R.string.localizable.restorePurchase(),
                                   action: { [ weak self ] in self?.restore() }))
        menu.append(module)
    }
    
    private func generateAboutUsMenuModule() {
        var module = MenuModule(title: R.string.localizable.informationAboutUs())
        module.rows.append(MenuRow(image: R.image.settingsAbout(),
                                   title: R.string.localizable.aboutUs(),
                                   action: { [ weak self ] in self?.coordinator.openModule(.aboutUs) }))
        menu.append(module)
    }
    
    private func generateInfoMenuModule() {
        var module = MenuModule(title: R.string.localizable.legalInformation())
        module.rows.append(MenuRow(image: R.image.settingsLegal(),
                                   title: R.string.localizable.termsOfUse(),
                                   action: { [ weak self ] in
                                    guard let url = self?.viewModel.termsOfUsageUrl
                                    else { return }
                                    UIApplication.shared.open(url)
                                   }))
        module.rows.append(MenuRow(image: R.image.settingsLegal(),
                                   title: R.string.localizable.privacyPolicy(),
                                   action: {[ weak self ] in
                                    guard let url = self?.viewModel.privacyPolicyUrl
                                    else { return }
                                    UIApplication.shared.open(url)
                                   }))
        menu.append(module)
    }
    
    // MARK: - UI elements actions

    @objc private func backButtonTapped() {
        coordinator.dismiss()
    }
    
    private func restore() {
        let loadingHUD = AlertManager.getLoadingHUD(on: _view)
        loadingHUD.show(in: _view)
//        viewModel.restorePurchases { [ weak self ] result in
//            guard let self = self
//            else { return }
//            loadingHUD.dismiss()
//            switch result {
//            case .failed:
//                AlertManager.showErrorHUD(on: self.view, withText: result.localized)
//
//            case .success:
//                AlertManager.showSuccessHUD(on: self.view, withText: result.localized)
//
//            case .nothingToRestore:
//                AlertManager.showErrorHUD(on: self.view, withText: result.localized)
//
//            }
//        }
    }
    
    private func purchaseCheck() {
//        let loadingHUD = AlertManager.getLoadingHUD(on: _view)
//        loadingHUD.show(in: _view)
        coordinator.openModule(.disableAdsPurchase, openingMode: .present)

//        viewModel.checkSubscriptionsStatus { [ weak self ] isActive in
//            guard let self = self
//            else { return }
//            loadingHUD.dismiss()
//            switch isActive {
//            case .active:
//                AlertManager.showSuccessHUD(on: self.view,
//                                            withText: NSLocalizedString("You already have active subscription!", comment: ""))
//            case .notPurchased:
//                self.coordinator.openModule(.subscription, openingMode: .present)
//            }
//        }
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !menu[section].title.isEmpty
        else { return nil }
        
        let view = UIView()
        view.backgroundColor = R.color.backgroundLight()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.gilroyLight(size: 16)
        label.text = menu[section].title
        label.textColor = R.color.tintColorDark()
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            label.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DialogTableViewCell.identifier, for: indexPath) as! DialogTableViewCell
        let menuRow = menu[indexPath.section].rows[indexPath.row]
        
        cell.setContent(menuRow)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return menu[section].title.isNotEmpty ? 75 : 0
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menu[indexPath.section].rows[indexPath.row].action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
