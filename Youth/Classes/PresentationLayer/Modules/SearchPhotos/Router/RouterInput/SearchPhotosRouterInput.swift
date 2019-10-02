//
//  SearchPhotosRouterInput.swift
//  Youth
//
//  Created by Cristian Lupu on 01/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

protocol SearchPhotosRouterInput: class {

    // swiftlint:disable:next identifier_name
    var photosCollectionSubModuleOnParentModuleReady: (() -> Void)? { get }
    var photosCollectionSubModuleOnLayoutChange: ((YouthCollectionLayout) -> Void)? { get }
    var photosCollectionSubModuleOnUsageChange: ((PhotosCollectionUsage) -> Void)? { get }

    func closeModule()

    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      subModuleOutput: PhotosCollectionModuleOutput)

    func showUserProfile(withUser user: Unsplash.User)

    func showPhotoDetails(withPhoto photo: Unsplash.Photo)

}
