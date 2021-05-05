//
//  AboutUsViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class AboutUsViewController: UIViewController {

    var viewModel: AboutUsViewModelProtocol!
    var coordinator: AboutUsCoordinatorProtocol!
    
    private var _view: AboutUsView {
        return view as! AboutUsView
    }

    override func loadView() {
        self.view = AboutUsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        navigationItem.title = R.string.localizable.aboutUs()
        navigationController?.navigationBar.tintColor = R.color.tintColorDark()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: R.font.westlake(size: 16)!,
                                                                   NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!]
    }
}
