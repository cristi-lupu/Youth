//
//  UserProfileModule.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class UserProfileModule {
    
    // MARK: View Controller
    let viewController: UIViewController
    
    // MARK: Module Input
    let moduleInput: UserProfileModuleInput
    
    required init(viewController: UIViewController, moduleInput: UserProfileModuleInput) {
        self.viewController = viewController
        self.moduleInput = moduleInput
    }
    
}
