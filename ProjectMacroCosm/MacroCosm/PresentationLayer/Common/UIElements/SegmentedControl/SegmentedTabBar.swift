//
//  SegmentedTabBar.swift
//  Albomika
//
//  Created by Антон Текутов on 18.08.2020.
//  Copyright © 2020 inostudio. All rights reserved.
//

import UIKit
import SwipeableTabBarController

// Custom SwipeTransitionAnimator
/// needs to handle transition start and completion to move selection view of segmented control

@objc(SwipeTransitionAnimator)
class SwipeTransitionAnimator: NSObject, SwipeTransitioningProtocol {
    
    // MARK: - SwipeTransitioningProtocol
    var animationDuration: TimeInterval
    var targetEdge: UIRectEdge
    var animationType: SwipeAnimationTypeProtocol = SwipeAnimationType.sideBySide
    
    var transitionCompletionHandler: ((_ cancelled: Bool) -> Void)?
    var transitionStartHandler: (() -> Void)?
    
    init(animationDuration: TimeInterval = 0.33,
         targetEdge: UIRectEdge = .right,
         animationType: SwipeAnimationTypeProtocol = SwipeAnimationType.sideBySide) {
        self.animationDuration = animationDuration
        self.targetEdge = targetEdge
        self.animationType = animationType
        super.init()
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return (transitionContext?.isAnimated == true) ? animationDuration : 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let fromRight = targetEdge == .right
        
        animationType.addTo(containerView: containerView, fromView: fromView, toView: toView)
        animationType.prepare(fromView: fromView, toView: toView, direction: fromRight)
        
        let duration = transitionDuration(using: transitionContext)
        
        transitionStartHandler?()
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveLinear],
                       animations: {
                        self.animationType.animation(fromView: fromView, toView: toView, direction: fromRight)
                       }, completion: { [ weak self ] _ in
                        self?.transitionCompletionHandler?(transitionContext.transitionWasCancelled)
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                       })
    }
}

enum SegmentedTabBarSegmentMode {
    case title
    case icon
}

class SegmentedTabBar: SwipeableTabBarController {
    
    private var tabBarTranslationIsExecutingSwipe = false {
        didSet {
            menuSegment.isUserInteractionEnabled = !(tabBarTranslationIsExecutingSwipe || tabBarTranslationIsExecutingSegment)
        }
    }
    private var tabBarTranslationIsExecutingSegment = false {
        didSet {
            menuSegment.isUserInteractionEnabled = !(tabBarTranslationIsExecutingSwipe || tabBarTranslationIsExecutingSegment)
        }
    }
    
    private var oldSelectedIndex: Int?
    override var selectedIndex: Int {
        didSet {
            if oldValue != selectedIndex {
                oldSelectedIndex = oldValue
                menuSegment.setSelectedSegmentIndex(selectedIndex)
            }
        }
    }
    
    var duration: TimeInterval = 0.3
    let menuSegment = SegmentedControl()
    
    var segmentViewMode = SegmentedTabBarSegmentMode.icon
    
    var defaultItemConfigurationClosure: ((_ : UIView, _ : UITabBarItem) -> Void)?
    var selectedItemConfigurationClosure: ((_ : UIView, _ : UITabBarItem) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMenuItems()
    }
    
    override func viewDidLoad() {
        setupMenuSegment()
        setupAnimator()
        setupItemConfigurators()
        
        tabBar.isHidden = true
        super.viewDidLoad()
    }
    
    // MARK: - Private setup methods
    
    private func setupMenuSegment() {
        view.addSubview(menuSegment)
        
        menuSegment.translatesAutoresizingMaskIntoConstraints = false
        menuSegment.backgroundColor = R.color.backgroundLight()
        menuSegment.delegate = self
        menuSegment.selectionView.backgroundColor = R.color.main()
        menuSegment.addTarget(self, action: #selector(selectionIndexDidChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            menuSegment.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            menuSegment.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 20)
        ])
    }
    
    private func setupAnimator() {
        let animator = SwipeTransitionAnimator()
        swipeAnimatedTransitioning = animator
        animator.transitionCompletionHandler = { [ weak self ] cancelled in
            self?.tabBarTranslationIsExecutingSwipe = false
            if cancelled {
                DispatchQueue.main.async {
                    self?.cancelMenuSegmentSelection()
                }
            }
        }
        animator.transitionStartHandler = { [ weak self ] in
            self?.tabBarTranslationIsExecutingSwipe = true
        }
    }
    
    private func cancelMenuSegmentSelection() {
        guard let old = oldSelectedIndex
        else { return }
        menuSegment.setSelectedSegmentIndex(old)
    }
    
    private func setupItemConfigurators() {
        defaultItemConfigurationClosure = { [ weak self ] view, item in
            guard let self = self
            else { return }
            UIView.transition(with: view, 
                              duration: self.duration, 
                              options: .transitionCrossDissolve) {
                switch self.segmentViewMode {
                case .title:
                    guard let label = view as? UILabel
                    else { return }
                    label.text = item.title
                    label.font = R.font.gilroyRegular(size: 14)
                    label.textAlignment = .center
                    label.textColor = self.tabBar.unselectedItemTintColor
                case .icon:
                    guard let image = view as? UIImageView
                    else { return }
                    image.image = item.image?.withRenderingMode(.alwaysTemplate)
                    image.tintColor = self.tabBar.unselectedItemTintColor
                }
            }
        }
        
        selectedItemConfigurationClosure = { [ weak self ] view, item in
            guard let self = self
            else { return }
            UIView.transition(with: view, 
                              duration: self.duration, 
                              options: .transitionCrossDissolve) {
                switch self.segmentViewMode {
                case .title:
                    guard let label = view as? UILabel
                    else { return }
                    label.font = R.font.gilroyRegular(size: 14)
                    label.textAlignment = .center
                    label.text = item.title
                    label.textColor = self.tabBar.tintColor
                case .icon:
                    guard let image = view as? UIImageView
                    else { return }
                    image.image = item.image?.withRenderingMode(.alwaysTemplate)
                    image.tintColor = self.tabBar.tintColor
                }
            }
        }
    }
    
    private func setupMenuItems() {
        guard let viewControllers = viewControllers 
        else { return }
        for view in menuSegment.stack.arrangedSubviews {
            view.removeFromSuperview()
        }
        for vcIndex in 0 ..< viewControllers.count {
            let vc = viewControllers[vcIndex]
            let config = vcIndex != selectedIndex ? defaultItemConfigurationClosure : selectedItemConfigurationClosure
            switch segmentViewMode {
            case .title:
                let label = UILabel()
                config?(label, vc.tabBarItem)
                menuSegment.addSegment(label)
            case .icon:
                let icon = UIImageView()
                icon.contentMode = .scaleAspectFit
                config?(icon, vc.tabBarItem)
                menuSegment.addSegment(icon)
            }
        }
    }
    
    // MARK: - UI elements actions
    
    @objc private func selectionIndexDidChanged() {
        if tabBarTranslationIsExecutingSwipe == false && tabBarTranslationIsExecutingSegment == false {
            selectedIndex = menuSegment.selectedSegmentIndex
            tabBarTranslationIsExecutingSegment = true
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(swipeAnimatedTransitioning?.animationDuration ?? duration), 
                                          execute: { [ weak self ] in
                                            guard let self = self 
                                            else { return }
                                            self.tabBarTranslationIsExecutingSegment = false
                                          })
        }
    }
}

extension SegmentedTabBar: SegmentedControlDelegate {
    
    func selectionDidChange(_ control: SegmentedControl, oldSelectedIndex: Int, newSelectedIndex: Int) {
        if oldSelectedIndex != newSelectedIndex,
           let viewItem = menuSegment.getSegmentWithIndex(oldSelectedIndex),
           let barItem = viewControllers?[oldSelectedIndex].tabBarItem {
            defaultItemConfigurationClosure?(viewItem, barItem)
        }
        if let viewItem = menuSegment.getSegmentWithIndex(newSelectedIndex),
           let barItem = viewControllers?[newSelectedIndex].tabBarItem {
            selectedItemConfigurationClosure?(viewItem, barItem)
        }
    }
}
