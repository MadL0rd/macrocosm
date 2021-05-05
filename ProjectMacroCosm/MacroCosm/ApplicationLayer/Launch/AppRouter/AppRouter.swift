//
//  AppRouter.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

protocol AppRouter: class {

	var window: UIWindow! { get set }
    
    func handleLaunch()
}
