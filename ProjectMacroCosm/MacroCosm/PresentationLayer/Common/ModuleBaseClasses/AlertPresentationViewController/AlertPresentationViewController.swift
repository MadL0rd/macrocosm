//
//  AlertPresentationViewController.swift
//  ApplicationName
//
//  Created by Антон Текутов on 20.05.2021.
//

import UIKit

class AlertPresentationViewController: UIViewController {
    
    private var currentTranslationValue: CGFloat = 0
    private var currentFraction: Float = 0
    
    private var alertPresentationView: AlertPresentationView {
        return view as! AlertPresentationView
    }

    override func loadView() {
        self.view = AlertPresentationView()
    }

    override func viewDidLoad() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = self
        
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDismissHandler))
        alertPresentationView.backgroundView.addGestureRecognizer(tap)
        
        configureGestures(view: alertPresentationView.backgroundView)
        configureGestures(view: alertPresentationView.contentView)
        
        alertPresentationView.setTransitionViewState(fractionCompletionState: -1, animated: false)
        alertPresentationView.setTransitionViewState(fractionCompletionState: 0, animated: true)
    }
    
    private func configureGestures(view: UIView) {
        view.isUserInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragView(_:)))
        view.addGestureRecognizer(pan)
    }
    
    private func dismissThisController() {
        if currentFraction > 0 {
            alertPresentationView.setTransitionViewState(fractionCompletionState: 1, animated: true)
        } else {
            alertPresentationView.setTransitionViewState(fractionCompletionState: -1, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + alertPresentationView.duration) { [ weak self ] in
            self?.dismissSelf()
        }
    }
    
    // MARK: - UI elements actions
    
    @objc private func tapToDismissHandler(recognizer: UITapGestureRecognizer) {
        dismissThisController()
    }
    
    @objc private func dragView(_ sender: UIPanGestureRecognizer) {
        
        let velocityVertical = abs(sender.velocity(in: alertPresentationView).y)
        
        let dragMaxValue = UIConstants.screenBounds.width * 0.5
        if sender.state == .began {
            currentTranslationValue = 0
            currentFraction = 0
        }
        switch sender.state {
        case .ended:
            guard (currentFraction < 0.4 && currentFraction > -0.4),
                  velocityVertical < 2000
            else {
                dismissThisController()
                return
            }
            alertPresentationView.setTransitionViewState(fractionCompletionState: 0, animated: true)
            
        default:
            let translation = sender.translation(in: alertPresentationView)
            currentTranslationValue += translation.y
            sender.setTranslation(CGPoint.zero, in: alertPresentationView)
            
            let fraction = min(max(currentTranslationValue, -dragMaxValue), dragMaxValue) / dragMaxValue
            currentFraction = Float(fraction)
            alertPresentationView.setTransitionViewState(fractionCompletionState: currentFraction,
                                                         animated: true,
                                                         duration: 0.1)
        }
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .down:
            currentFraction = -1
            dismissThisController()
        case .up:
            currentFraction = 1
            dismissThisController()
        default:
            break
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension AlertPresentationViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return UIPresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
}
