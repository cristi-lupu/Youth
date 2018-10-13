//
//  PhotoViewerAssembly.swift
//  Youth
//
//  Created by Cristian Lupu on 16/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotoViewerAssembly {
    
    func assemblyPhotoViewerModule() -> PhotoViewerModule {
        let view = PhotoViewerViewController()
        let presenter = PhotoViewerPresenter()
        let router = PhotoViewerRouter()
        let state = PhotoViewerState()
        let interactor = PhotoViewerInteractor()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.state = state
        interactor.output = presenter
        router.viewController = view
        
        return PhotoViewerModule(viewController: view, moduleInput: presenter)
    }
    
}
