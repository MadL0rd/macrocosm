//
//  LoadingViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    var viewModel: LoadingViewModelProtocol!
    var coordinator: LoadingCoordinatorProtocol!
    
    private var _view: LoadingView {
        return view as! LoadingView
    }
    
    override func loadView() {
        self.view = LoadingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
    }
    
    private func configureSelf() {
        UIStyleManager.setUIBarButtonItemsClear()
        
        viewModel.startConfiguration()
        
        _view.hideLogo()
        DispatchQueue.main.asyncAfter(deadline: .now() + _view.hideLogoDuration * 0.6) { [ weak self ] in
            guard let self = self
            else { return }
            if self.viewModel.userInfo.isFilled {
                self.coordinator.showMainScreen()
            } else {
                self.coordinator.showUserInfoEditor()
            }
            
        }
    }
}
