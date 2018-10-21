//
//  PhotoDetailsRouter.swift
//  Youth
//
//  Created by Cristian Lupu on 10/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotoDetailsRouter {

    weak var viewController: UIViewController?

}

extension PhotoDetailsRouter: PhotoDetailsRouterInput {

    func closeModule() {
        viewController?.dismiss(animated: true)
    }

    func showUserProfile(withUser user: UnsplashUser) {
        guard let navigationController = viewController?.navigationController else {
            return
        }

        let userProfileAssembly = UserProfileAssembly()
        let userProfileModule = userProfileAssembly.assemblyUserProfileModule()

        userProfileModule.moduleInput.configure(withUser: user)

        navigationController.pushViewController(userProfileModule.viewController, animated: true)
    }

}
