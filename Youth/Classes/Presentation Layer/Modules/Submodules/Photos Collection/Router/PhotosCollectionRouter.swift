//
//  PhotosCollectionRouter.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
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
