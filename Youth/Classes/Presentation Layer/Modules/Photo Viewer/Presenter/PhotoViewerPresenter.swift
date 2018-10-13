//
//  PhotoViewerPresenter.swift
//  Youth
//
//  Created by Cristian Lupu on 16/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

final class PhotoViewerPresenter {
    
    // MARK: View
    
    weak var view: PhotoViewerViewInput?
    
    // MARK: Interactor
    
    var interactor: PhotoViewerInteractorInput?
    
    // MARK: Router
    
    var router: PhotoViewerRouterInput?
    
    // MARK: State
    
    var state = PhotoViewerState()
    
    // MARK: Module Output
    
    weak var moduleOutput: PhotoViewerModuleOutput?
    
}

// MARK: PhotoViewerViewOutput

extension PhotoViewerPresenter: PhotoViewerViewOutput {
    
    func viewIsReady() {
        view?.setUpInitialState()
    }   
    
}

// MARK: PhotoViewerInteractorOutput

extension PhotoViewerPresenter: PhotoViewerInteractorOutput {
    
    
}

// MARK: PhotoViewerModuleInput

extension PhotoViewerPresenter: PhotoViewerModuleInput {
    
    func set(moduleOutput: PhotoViewerModuleOutput) {
        self.moduleOutput = moduleOutput
    }
    
}
