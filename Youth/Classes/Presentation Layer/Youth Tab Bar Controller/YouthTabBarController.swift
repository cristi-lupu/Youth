//
//  YouthTabBarController.swift
//  Youth
//
//  Created by Cristian Lupu on 5/10/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Main Tab Bar Controller Class
final class YouthTabBarController: UITabBarController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var verticalOffset: CGFloat = 6.0

        if #available(iOS 11.0, *), traitCollection.horizontalSizeClass == .regular {
            verticalOffset = 0.0
        }

        let imageInset = UIEdgeInsets(top: verticalOffset,
                                      left: 0.0,
                                      bottom: -verticalOffset,
                                      right: 0.0)

        for tabBarItem in tabBar.items ?? [] {
            tabBarItem.title = ""
            tabBarItem.imageInsets = imageInset
        }
    }
}
