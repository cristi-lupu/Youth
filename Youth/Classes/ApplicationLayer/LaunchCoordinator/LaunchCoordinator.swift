//
//  LaunchCoordinator.swift
//  Youth
//
//  Created by Cristian Lupu on 5/9/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Handle application launch
final class LaunchCoordinator {
    /**
     Handle launch
     
     - parameter window: UIWindow where to launch
     */
    func launch(on window: UIWindow?) {
        let tabBarControllerAssembly = YouthTabControllerAssembly()
        window?.rootViewController = tabBarControllerAssembly.assemblyTabBarController()
        window.map(changeAppearanceOfWindowIfNeeded)
        window?.makeKeyAndVisible()
    }

    private func changeAppearanceOfWindowIfNeeded(_ window: UIWindow) {
        if #available(iOS 13, *) {
            window.overrideUserInterfaceStyle = .light
        }
    }
}
