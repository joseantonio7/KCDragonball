//
//  SceneDelegate.swift
//  KCDragonball
//
//  Created by José Antonio Aravena on 28-09-24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)

        window.rootViewController = LoginViewController()
        window.makeKeyAndVisible()
        self.window = window
    }

}

