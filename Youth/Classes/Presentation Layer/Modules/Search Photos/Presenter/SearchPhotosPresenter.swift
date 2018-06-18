//
//  SearchPhotosPresenter.swift
//  Youth
//
//  Created by Lupu Cristian on 01/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class SearchPhotosPresenter {
    
    // MARK: View
    
    public weak var view: SearchPhotosViewInput?

    // MARK: Interactor

    public var interactor: SearchPhotosInteractorInput?

    // MARK: Router

    public var router: SearchPhotosRouterInput?

    // MARK: State

    public var state = SearchPhotosState()
    
}

// MARK: SearchPhotosViewOutput

extension SearchPhotosPresenter: SearchPhotosViewOutput {
    
    public func viewIsReady() {
        guard let view = view else {
            return
        }
        
        view.setUpInitialState(collectionLayout: state.collectionLayout.inversed)

        router?.addPhotosCollectionSubmodule(on: view.photosCollectionCanvasView(),
                                             layout: state.collectionLayout,
                                             usage: .searchPhotos(query: ""),
                                             subModuleOutput: self)

        router?.photosCollectionSubModuleOnParentModuleReady?()
    }

    public func didTapLayoutButton() {
        switch state.collectionLayout {
        case .grid:
            state.collectionLayout = .list
        case .list:
            state.collectionLayout = .grid
        }

        // Update View
        view?.updateState(for: state.collectionLayout.inversed)

        // Update submodule
        router?.photosCollectionSubModuleOnLayoutChange?(state.collectionLayout)
    }

    public func viewDidAppear() {
        view?.showKeyboard()
    }

    public func didChange(searchText: String) {
        router?.photosCollectionSubModuleOnUsageChange?(.searchPhotos(query: searchText))
    }
    
}

// MARK: PhotosCollectionModuleOutput

extension SearchPhotosPresenter: PhotosCollectionModuleOutput {

    public func didSelectPhoto(_ photo: UnsplashPhoto) {
        router?.showPhotoDetails(withPhoto: photo)
    }

    public func didSelectUser(_ user: UnsplashUser) {
        router?.showUserProfile(withUser: user)
    }

    public func didSavePhoto(success: Bool, error: Error?) {
        if success {
            view?.showNotification(withText: "Photo saved")
        } else {
            view?.showNotification(withText: "Could not save photo")
        }
    }

    public func didChangePhotosCollectionContentHeight(_ height: CGFloat) {}

}

// MARK: SearchPhotosInteractorOutput

extension SearchPhotosPresenter: SearchPhotosInteractorOutput {

}
