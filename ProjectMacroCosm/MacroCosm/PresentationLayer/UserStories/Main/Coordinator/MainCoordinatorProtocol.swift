//
//  MainCoordinatorProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

protocol MainCoordinatorProtocol: DefaultCoordinatorProtocol {
    
    func generateTodayModule() -> UIViewController
    func generateGeneralModule() -> UIViewController
}
