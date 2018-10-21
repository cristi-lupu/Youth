//
//  SearchPhotosPresenter.swift
//  Youth
//
//  Created by Cristian Lupu on 01/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class SearchPhotosPresenter {

    // MARK: View

    weak var view: SearchPhotosViewInput?

    // MARK: Interactor

    var interactor: SearchPhotosInteractorInput?

    // MARK: Router

    var router: SearchPhotosRouterInput?

    // MARK: State

    var state = SearchPhotosState()
}

// MARK: SearchPhotosViewOutput

extension SearchPhotosPresenter: SearchPhotosViewOutput {

    func viewIsReady() {
        guard let view = view else { return }

        view.setUpInitialState(collectionLayout: state.collectionLayout.inversed)

        router?.addPhotosCollectionSubmodule(on: view.photosCollectionCanvasView(),
                                             layout: state.collectionLayout,
                                             usage: .searchPhotos(query: ""),
                                             subModuleOutput: self)

        router?.photosCollectionSubModuleOnParentModuleReady?()
    }

    func didTapLayoutButton() {
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

    func viewDidAppear() {
        view?.showKeyboard()
    }

    func didChange(searchText: String) {
        router?.photosCollectionSubModuleOnUsageChange?(.searchPhotos(query: searchText))
    }
}

// MARK: PhotosCollectionModuleOutput

extension SearchPhotosPresenter: PhotosCollectionModuleOutput {

    func didSelectPhoto(_ photo: UnsplashPhoto) {
        router?.showPhotoDetails(withPhoto: photo)
    }

    func didSelectUser(_ user: UnsplashUser) {
        router?.showUserProfile(withUser: user)
    }

    func didSavePhoto(success: Bool, error: Error?) {
        if success {
            view?.showNotification(withText: "Photo saved")
        } else {
            view?.showNotification(withText: "Could not save photo")
        }
    }

    func didChangePhotosCollectionContentHeight(_ height: CGFloat) {}
}

// MARK: SearchPhotosInteractorOutput

extension SearchPhotosPresenter: SearchPhotosInteractorOutput { }
