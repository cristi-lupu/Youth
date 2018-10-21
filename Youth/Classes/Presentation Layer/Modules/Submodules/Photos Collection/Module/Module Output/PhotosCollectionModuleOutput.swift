//
//  PhotosCollectionModuleOutput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import CoreGraphics

protocol PhotosCollectionModuleOutput: class {

    func didSelectPhoto(_ photo: UnsplashPhoto)

    func didSelectUser(_ user: UnsplashUser)

    func didChangePhotosCollectionContentHeight(_ height: CGFloat)

    func didSavePhoto(success: Bool, error: Error?)

}
