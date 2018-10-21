//
//  PhotosRouterInput.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

protocol PhotosRouterInput: class {
    // swiftlint:disable:next identifier_name
    var photosCollectionSubModuleOnParentModuleReady: (() -> Void)? { get }
    var photosCollectionSubModuleOnLayoutChange: ((YouthCollectionLayout) -> Void)? { get }
    var photosCollectionSubModuleOnUsageChange: ((PhotosCollectionUsage) -> Void)? { get }

    func closeModule()

    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      subModuleOutput: PhotosCollectionModuleOutput)

    func showUserProfile(withUser user: UnsplashUser)

    func showPhotoDetails(withPhoto photo: UnsplashPhoto)

    func showSearchPhotos()
}
