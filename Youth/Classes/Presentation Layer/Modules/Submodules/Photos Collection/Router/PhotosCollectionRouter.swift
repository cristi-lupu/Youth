//
//  PhotosCollectionRouter.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotosCollectionRouter {
    weak var view: UIView?
}

extension PhotosCollectionRouter: PhotosCollectionRouterInput {
    func closeModule() {
        view?.removeFromSuperview()
    }
}
