//
//  AppDelegate.swift
//  ToolboxApp
//
//  Created by Laura Sarmiento Almanza on 10/12/19.
//  Copyright © 2019 Laura Sarmiento Almanza. All rights reserved.
//

import UIKit
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let wireframe = MovieWireframe()
        let navigationController = UINavigationController(rootViewController: wireframe.viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
        
        self.navigationController = navigationController
        self.window = window
        
        window.makeKeyAndVisible()
        return true
    }
}

