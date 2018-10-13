//
//  UserProfileViewInput.swift
//  Youth
//
//  Created by Cristian Lupu on 19/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

protocol UserProfileViewInput: class {
    
    func setUpInitialState(withViewModel viewModel: UserProfileViewModel)
    
    func photosCollectionCanvasView() -> UIView
    
    func photosCollectionScrollOwner() -> PhotosCollectionScrollOwner?
    
    func updatePhotosCollectionCanvasViewHeight(_ height: CGFloat)
    
}
