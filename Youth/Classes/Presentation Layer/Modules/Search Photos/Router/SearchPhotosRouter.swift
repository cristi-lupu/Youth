//
//  SearchPhotosRouter.swift
//  Youth
//
//  Created by Lupu Cristian on 01/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class SearchPhotosRouter: SearchPhotosRouterInput {
    
    weak var viewController: UIViewController?
    
    var photosCollectionSubModuleOnParentModuleReady: (() -> ())?
    var photosCollectionSubModuleOnLayoutChange: ((YouthCollectionLayout) -> ())?
    var photosCollectionSubModuleOnUsageChange: ((PhotosCollectionUsage) -> ())?
    
    func closeModule() {
        viewController?.dismiss(animated: true)
    }
    
    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      subModuleOutput: PhotosCollectionModuleOutput) {
        let photosCollectionAssembly = PhotosCollectionAssembly()
        let photosCollectionModule = photosCollectionAssembly.assemblyPhotosCollectionModule()
        
        let subModuleInput = photosCollectionModule.moduleInput
        subModuleInput.configure(collectionLayout: layout, usage: usage)
        subModuleInput.set(moduleOutput: subModuleOutput)
        
        photosCollectionSubModuleOnParentModuleReady = { [weak subModuleInput] in
            guard let strongSubModuleInput = subModuleInput else {
                return
            }
            
            strongSubModuleInput.parentModuleIsReady()
        }
        
        photosCollectionSubModuleOnLayoutChange = { [weak subModuleInput] (collectionLayout) in
            guard let strongSubModuleInput = subModuleInput else {
                return
            }
            
            strongSubModuleInput.change(layout: collectionLayout)
        }
        
        photosCollectionSubModuleOnUsageChange = { [weak subModuleInput] (usage) in
            guard let strongSubModuleInput = subModuleInput else {
                return
            }
            
            strongSubModuleInput.change(usage: usage)
        }
        
        let subModuleView = photosCollectionModule.view
        canvasView.addSubview(subModuleView)
        
        subModuleView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    
    func showUserProfile(withUser user: UnsplashUser) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        
        let userProfileAssembly = UserProfileAssembly()
        let userProfileModule = userProfileAssembly.assemblyUserProfileModule()
        
        userProfileModule.moduleInput.configure(withUser: user)
        
        navigationController.pushViewController(userProfileModule.viewController, animated: true)
    }
    
    func showPhotoDetails(withPhoto photo: UnsplashPhoto) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        
        let photoDetailsAssembly = PhotoDetailsAssembly()
        let photoDetailsModule = photoDetailsAssembly.assemblyPhotoDetailsModule()
        
        photoDetailsModule.moduleInput.configure(withPhoto: photo)
        
        navigationController.pushViewController(photoDetailsModule.viewController, animated: true)
    }
    
}
