//
//  PhotoDetailsModule.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class PhotoDetailsModule {

    // MARK: View Controller

    let viewController: UIViewController

    // MARK: Module Input

    let moduleInput: PhotoDetailsModuleInput

    required init(viewController: UIViewController, moduleInput: PhotoDetailsModuleInput) {
        self.viewController = viewController
        self.moduleInput = moduleInput
    }

}
