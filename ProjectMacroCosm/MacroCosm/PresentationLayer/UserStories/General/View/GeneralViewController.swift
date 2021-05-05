//
//  GeneralViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class GeneralViewController: UIViewController {

    var viewModel: GeneralViewModelProtocol!
    var coordinator: GeneralCoordinatorProtocol!
    
    private var _view: GeneralView {
        return view as! GeneralView
    }

    override func loadView() {
        self.view = GeneralView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        
        viewModel.zodiacPredictionWillChange = { [ weak self ] in
            self?._view.setLoadingState(isActive: true, animated: false)
        }
        
        viewModel.zodiacPredictionDidChanged = { [ weak self ] prediction in
            DispatchQueue.main.async {
                self?.setPrediction(prediction)
            }
        }
        viewModel.loadData()
    }
    
    private func setPrediction(_ prediction: ZodiacPrediction) {
        _view.setLoadingState(isActive: false)
        
        _view.imageView.setDefaultLoadingInicator()
        _view.imageView.sd_setImage(with: prediction.zodiacImageUrl, completed: nil)
        _view.zodiacNameLabel.text = prediction.zodiacName
        _view.zodiacInfoTextLabel.text = prediction.zodiacDescription
        _view.predictionLabel.text = prediction.zodiacInfoText
    }
}
