//
//  UserProfileRouterInput.swift
//  Youth
//
//  Created by Cristian Lupu on 19/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

protocol UserProfileRouterInput: class {

    // swiftlint:disable:next identifier_name
    var photosCollectionSubModuleOnParentModuleReady: (() -> Void)? { get }

    func closeModule()

    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      scrollEnabled: Bool,
                                      scrollOwner: PhotosCollectionScrollOwner?,
                                      subModuleOutput: PhotosCollectionModuleOutput)

    func showPhotoDetails(withPhoto photo: Unsplash.Photo)

}
