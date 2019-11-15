//
//  SceneDelegate.swift
//  OnTheMap
//
//  Created by David Chea on 06/11/2019.
//  Copyright © 2019 David Chea. All rights reserved.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Property
    
    var window: UIWindow?
    
    // MARK: - Protocol method

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: LoginView().environmentObject(AppData()))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
