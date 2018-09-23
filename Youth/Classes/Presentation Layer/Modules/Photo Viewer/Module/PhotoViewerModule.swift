//
//  PhotoViewerModule.swift
//  Youth
//
//  Created by Lupu Cristian on 16/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
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
