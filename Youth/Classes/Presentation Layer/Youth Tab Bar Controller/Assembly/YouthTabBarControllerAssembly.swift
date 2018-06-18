//
//  YouthTabBarControllerAssembly.swift
//  Youth
//
//  Created by Lupu Cristian on 5/10/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Assembly for main tab bar controller of app
public final class YouthTabControllerAssembly {

    public func assemblyTabBarController() -> UITabBarController {
        let tabBarController = YouthTabBarController()

        let photosViewController = self.photosViewController()
        photosViewController.tabBarItem.image = R.image.tabBar.photos.photosInactive()
        photosViewController.tabBarItem.selectedImage = R.image.tabBar.photos.photosActive()

        tabBarController.viewControllers = [photosViewController]

        // Configure tab bar
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.shadowImage = UIImage()
        tabBarController.tabBar.layer.borderWidth = 0.0
        tabBarController.tabBar.clipsToBounds = true

        return tabBarController
    }

    private func photosViewController() -> UIViewController {
        return PhotosAssembly().assemblyPhotosModule()
    }
    
}
