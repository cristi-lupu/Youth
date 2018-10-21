//
//  UserProfileModule.swift
//  Youth
//
//  Created by Cristian Lupu on 19/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
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
