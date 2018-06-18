//
//  PhotosRouterInput.swift
//  Youth
//
//  Created by Lupu Cristian on 09/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public protocol PhotosRouterInput: class {

    var photosCollectionSubModuleOnParentModuleReady: (() -> ())? { get set }
    var photosCollectionSubModuleOnLayoutChange: ((YouthCollectionLayout) -> ())? { get set }
    var photosCollectionSubModuleOnUsageChange: ((PhotosCollectionUsage) -> ())? { get set }

    func closeModule()

    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      subModuleOutput: PhotosCollectionModuleOutput)

    func showUserProfile(withUser user: UnsplashUser)

    func showPhotoDetails(withPhoto photo: UnsplashPhoto)

    func showSearchPhotos()

}
