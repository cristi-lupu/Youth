//
//  LaunchCoordinator.swift
//  Youth
//
//  Created by Lupu Cristian on 5/9/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Handle application launch
public final class LaunchCoordinator {

    /**
     Handle launch

     - parameter window: UIWindow where to launch
    */
    public func launch(on window: UIWindow?) {
        let tabBarControllerAssembly = YouthTabControllerAssembly()
        window?.rootViewController = tabBarControllerAssembly.assemblyTabBarController()
        window?.makeKeyAndVisible()
    }

}
