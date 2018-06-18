//
//  SearchPhotosRouterInput.swift
//  Youth
//
//  Created by Lupu Cristian on 01/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public protocol SearchPhotosRouterInput: class {

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

}
