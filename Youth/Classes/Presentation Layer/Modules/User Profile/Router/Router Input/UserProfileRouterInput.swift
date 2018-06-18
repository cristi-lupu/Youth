//
//  UserProfileRouterInput.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public protocol UserProfileRouterInput: class {

    var photosCollectionSubModuleOnParentModuleReady: (() -> ())? { get set }
	
	func closeModule()

    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      scrollEnabled: Bool,
                                      scrollOwner: PhotosCollectionScrollOwner?,
                                      subModuleOutput: PhotosCollectionModuleOutput)

    func showPhotoDetails(withPhoto photo: UnsplashPhoto)

}
