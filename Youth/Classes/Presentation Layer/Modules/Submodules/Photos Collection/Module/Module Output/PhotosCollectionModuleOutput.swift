//
//  PhotosCollectionModuleOutput.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import CoreGraphics

public protocol PhotosCollectionModuleOutput: class {

    func didSelectPhoto(_ photo: UnsplashPhoto)
	
    func didSelectUser(_ user: UnsplashUser)

    func didChangePhotosCollectionContentHeight(_ height: CGFloat)

    func didSavePhoto(success: Bool, error: Error?)
	
}
