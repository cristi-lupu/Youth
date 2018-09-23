//
//  YouthTabBarController.swift
//  Youth
//
//  Created by Lupu Cristian on 5/10/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Main Tab Bar Controller Class
final class YouthTabBarController: UITabBarController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // https://stackoverflow.com/questions/26494130/remove-tab-bar-item-text-show-only-image?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
        
        // iOS 11: puts the titles to the right of image for horizontal size class regular. Only want offset when compact.
        // iOS 9 & 10: always puts titles under the image. Always want offset.
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
