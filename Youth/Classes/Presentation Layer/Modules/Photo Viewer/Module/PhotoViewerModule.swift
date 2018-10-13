//
//  PhotoViewerModule.swift
//  Youth
//
//  Created by Cristian Lupu on 16/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotoViewerModule {
    
    // MARK: View Controller
    
    let viewController: UIViewController
    
    // MARK: Module Input
    
    let moduleInput: PhotoViewerModuleInput
    
    required init(viewController: UIViewController, moduleInput: PhotoViewerModuleInput) {
        self.viewController = viewController
        self.moduleInput = moduleInput
    }
    
}
