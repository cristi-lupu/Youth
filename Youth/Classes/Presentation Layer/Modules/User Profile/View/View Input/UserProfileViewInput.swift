//
//  UserProfileViewInput.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public protocol UserProfileViewInput: class {

    func setUpInitialState(withViewModel viewModel: UserProfileViewModel)

    func photosCollectionCanvasView() -> UIView

    func photosCollectionScrollOwner() -> PhotosCollectionScrollOwner?

    func updatePhotosCollectionCanvasViewHeight(_ height: CGFloat)
    
}
