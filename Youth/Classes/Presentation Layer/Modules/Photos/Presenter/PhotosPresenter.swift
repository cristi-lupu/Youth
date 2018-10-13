//
//  PhotosPresenter.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import CoreGraphics

final class PhotosPresenter {
    
    // MARK: View
    
    weak var view: PhotosViewInput?
    
    // MARK: Interactor
    
    var interactor: PhotosInteractorInput?
    
    // MARK: Router
    
    var router: PhotosRouterInput?
    
    // MARK: State
    
    var state = PhotosState()
    
}

// MARK: PhotosViewOutput

extension PhotosPresenter: PhotosViewOutput {
    
    func viewIsReady() {
        guard let view = view else {
            return
        }
        
        let photoCategoriesTitles = PhotosCategoryType.allInOrder.map {
            $0.description
        }
        
        let photoCategoriesStartIndex = state.photosCategoriesCurrentIndex
        
        view.setUpInitialState(collectionLayout: state.collectionLayout.inversed,
                               photosCategoriesTitles: photoCategoriesTitles,
                               photosCategoriesCurrentIndex: photoCategoriesStartIndex)
        
        let orderBy = photosOrderBy(from: state.photosCategory)
        
        router?.addPhotosCollectionSubmodule(on: view.photosCollectionCanvasView(),
                                             layout: state.collectionLayout,
                                             usage: .photos(orderBy: orderBy),
                                             subModuleOutput: self)
        
        defer {
            router?.photosCollectionSubModuleOnParentModuleReady?()
        }
    }
    
    func didTapSearchButton() {
        router?.showSearchPhotos()
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
    
    func didChangePhotosCategory(at index: Int) {
        let allPhotosCategories = PhotosCategoryType.allInOrder
        let orderBy = photosOrderBy(from: allPhotosCategories[index])
        router?.photosCollectionSubModuleOnUsageChange?(.photos(orderBy: orderBy))
    }
    
}

// MARK: PhotosInteractorOutput

extension PhotosPresenter: PhotosInteractorOutput {
    
}

// MARK: PhotosCollectionModuleOutput

extension PhotosPresenter: PhotosCollectionModuleOutput {
    
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

extension PhotosPresenter {
    
    private func photosOrderBy(from photosCategory: PhotosCategoryType) -> UnsplashPhotosOrderBy {
        let orderBy: UnsplashPhotosOrderBy
        
        switch photosCategory {
        case .latest:
            orderBy = .latest
        case .popular:
            orderBy = .popular
        case .oldest:
            orderBy = .oldest
        }
        
        return orderBy
    }
    
}
