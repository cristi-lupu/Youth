//
//  YouthNavigationController.swift
//  Youth
//
//  Created by Cristian Lupu on 5/20/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Main navigation controller of app
final class YouthNavigationController: UINavigationController {
    convenience init(initialViewController: UIViewController) {
        self.init(navigationBarClass: YouthNavigationBar.self, toolbarClass: nil)
        
        viewControllers = [initialViewController]
    }
}
