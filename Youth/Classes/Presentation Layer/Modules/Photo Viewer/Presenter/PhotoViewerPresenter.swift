//
//  PhotoViewerPresenter.swift
//  Youth
//
//  Created by Lupu Cristian on 16/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public final class PhotoViewerPresenter {
    
    // MARK: View
    
    public weak var view: PhotoViewerViewInput?

    // MARK: Interactor

    public var interactor: PhotoViewerInteractorInput?

    // MARK: Router

    public var router: PhotoViewerRouterInput?

    // MARK: State

    public var state = PhotoViewerState()

    // MARK: Module Output

    public weak var moduleOutput: PhotoViewerModuleOutput?
    
}

// MARK: PhotoViewerViewOutput

extension PhotoViewerPresenter: PhotoViewerViewOutput {
    
    public func viewIsReady() {
        view?.setUpInitialState()
    }   
    
}

// MARK: PhotoViewerInteractorOutput

extension PhotoViewerPresenter: PhotoViewerInteractorOutput {

    
}

// MARK: PhotoViewerModuleInput

extension PhotoViewerPresenter: PhotoViewerModuleInput {

    public func set(moduleOutput: PhotoViewerModuleOutput) {
        self.moduleOutput = moduleOutput
    }
    
}
