//
//  AppDelegate.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.21.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appRouter: AppRouter!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { 
            return 
        }
        
        PurchaseManager.shared.completeTransactions()
        
        window = UIWindow(windowScene: windowScene)        
        window?.makeKeyAndVisible()
        
        appRouter = ApplicationAssembly.appRouter
        appRouter.window = window!
        appRouter.handleLaunch()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
