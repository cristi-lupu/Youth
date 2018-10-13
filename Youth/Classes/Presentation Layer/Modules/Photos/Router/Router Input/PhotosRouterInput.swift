//
//  PhotosRouterInput.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

protocol PhotosRouterInput: class {
    
    var photosCollectionSubModuleOnParentModuleReady: (() -> ())? { get }
    var photosCollectionSubModuleOnLayoutChange: ((YouthCollectionLayout) -> ())? { get }
    var photosCollectionSubModuleOnUsageChange: ((PhotosCollectionUsage) -> ())? { get }
    
    func closeModule()
    
    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      subModuleOutput: PhotosCollectionModuleOutput)
    
    func showUserProfile(withUser user: UnsplashUser)
    
    func showPhotoDetails(withPhoto photo: UnsplashPhoto)
    
    func showSearchPhotos()
    
}
