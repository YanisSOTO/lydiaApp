//
//  SceneDelegate.swift
//  lydiaApp
//
//  Created by Yanis Soto on 27/11/2019.
//  Copyright © 2019 Yanis Soto. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let rootController = UINavigationController()
        
        ///Create our first navigator. Contain the main navigation
        let navigator = MainNavigator(navigationController: rootController)
        let controller = ContactListViewController(navigator: navigator)
        rootController.setViewControllers([controller],
                                          animated: false)
        self.window?.rootViewController = rootController
        self.window?.makeKeyAndVisible()
    }
}

