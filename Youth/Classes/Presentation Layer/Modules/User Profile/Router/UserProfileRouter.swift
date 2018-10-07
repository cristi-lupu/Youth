//
//  UserProfileRouter.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class UserProfileRouter: UserProfileRouterInput {
    
    private(set) var photosCollectionSubModuleOnParentModuleReady: (() -> ())?
    
    weak var viewController: UIViewController?
    
    func closeModule() {
        viewController?.dismiss(animated: true)
    }
    
    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      scrollEnabled: Bool,
                                      scrollOwner: PhotosCollectionScrollOwner?,
                                      subModuleOutput: PhotosCollectionModuleOutput) {
        let photosCollectionAssembly = PhotosCollectionAssembly()
        let photosCollectionModule = photosCollectionAssembly.assemblyPhotosCollectionModule(scrollOwner: scrollOwner)
        
        let subModuleInput = photosCollectionModule.moduleInput
        subModuleInput.configure(collectionLayout: layout, usage: usage)
        subModuleInput.set(moduleOutput: subModuleOutput)
        subModuleInput.set(scrollEnabled: scrollEnabled)
        
        photosCollectionSubModuleOnParentModuleReady = { [weak subModuleInput] in
            guard let strongSubModuleInput = subModuleInput else {
                return
            }
            
            strongSubModuleInput.parentModuleIsReady()
        }
        
        let subModuleView = photosCollectionModule.view
        canvasView.addSubview(subModuleView)
        
        subModuleView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
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
