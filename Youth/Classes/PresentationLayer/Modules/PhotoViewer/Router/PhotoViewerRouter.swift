//
//  PhotoViewerRouter.swift
//  Youth
//
//  Created by Cristian Lupu on 16/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotoViewerRouter {

    weak var viewController: UIViewController?

}

extension PhotoViewerRouter: PhotoViewerRouterInput {

    func closeModule() {
        viewController?.dismiss(animated: true)
    }

}
