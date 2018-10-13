//
//  AppDelegate.swift
//  Youth
//
//  Created by Cristian Lupu on 4/21/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Fabric with Crashlytics
        Fabric.with([Crashlytics.self])
        
        // Handle application launch
        window = UIWindow(frame: UIScreen.main.bounds)
        let launchCoordinator = LaunchCoordinator()
        launchCoordinator.launch(on: window)
        return true
    }
    
    // Only portrait interface orientation (maybe, will be and landscape)
    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.portrait]
    }
    
}
