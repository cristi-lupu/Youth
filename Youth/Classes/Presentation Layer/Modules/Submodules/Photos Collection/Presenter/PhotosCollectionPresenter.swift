//
//  PhotosCollectionPresenter.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit
import Permission

final class PhotosCollectionPresenter {
    
    // MARK: View
    
    weak var view: PhotosCollectionViewInput?
    
    // MARK: Interactor
    
    var interactor: PhotosCollectionInteractorInput?
    
    // MARK: Router
    
    var router: PhotosCollectionRouterInput?
    
    // MARK: State
    
    var state = PhotosCollectionState()
    
    // MARK: Module Output
    
    weak var moduleOutput: PhotosCollectionModuleOutput?
    
    // MARK: View Model Builder
    
    let viewModelBuilder: PhotosCollectionCellViewModelBuilder
    
    // MARK: Photos Permission
    
    let photosPermission: Permission
    
    init(viewModelBuilder: PhotosCollectionCellViewModelBuilder,
         photosPermission: Permission) {
        self.viewModelBuilder = viewModelBuilder
        self.photosPermission = photosPermission
        
        photosPermission.presentDeniedAlert = true
        photosPermission.presentDisabledAlert = true
    }
    
}

// MARK: PhotosCollectionViewOutput

extension PhotosCollectionPresenter: PhotosCollectionViewOutput {
    
    func didTapImage(on indexPath: IndexPath) {
        guard let photo = state.photos[safe: indexPath.item] else {
            return
        }
        moduleOutput?.didSelectPhoto(photo)
    }
    
    func didTouchUpInsideLikeButton(on indexPath: IndexPath) {
        print("didTouchUpInsideLikeButton on \(indexPath)")
    }
    
    func didTouchUpInsideShareButton(on indexPath: IndexPath) {
        print("didTouchUpInsideShareButton on \(indexPath)")
    }
    
    func didTapDownloadButton(on indexPath: IndexPath) {
        guard let interactor = interactor,
            let photo = state.photos[safe: indexPath.item],
            let id = photo.id else {
                return
        }
        
        if interactor.isDownloadingPhoto(withID: id) {
            interactor.cancelDownloadingPhoto(withID: id)
            view?.setDownloadState(atIndex: indexPath.item)
        } else {
            interactor.download(photo: photo)
            view?.updateDownloadingStateOfPhoto(atIndex: indexPath.item, progress: 0.0)
        }
    }
    
    func didTapUser(on indexPath: IndexPath) {
        guard let user = state.photos[safe: indexPath.item]?.user else {
            return
        }
        
        moduleOutput?.didSelectUser(user)
    }
    
    func didChangeContentHeight(_ height: CGFloat) {
        moduleOutput?.didChangePhotosCollectionContentHeight(height)
    }
    
}

extension PhotosCollectionPresenter: PhotosCollectionScrollingUpdateReceiver {
    
    func didScrollPhotosCollectionAtTheEndOfTheContent() {
        guard !state.isRequesting,
            state.hasMorePhotos else {
                return
        }
        
        state.isRequesting = true
        
        view?.showBottomLoading()
        
        switch state.usage {
        case let .photos(orderBy):
            interactor?.obtainPhotos(atPage: state.pagination.currentPage + 1,
                                     perPage: state.pagination.perPage,
                                     orderBy: orderBy)
        case let .userPhotos(username, orderBy):
            interactor?.obtainUserPhotos(username: username,
                                         atPage: state.pagination.currentPage + 1,
                                         perPage: state.pagination.perPage,
                                         orderBy: orderBy)
        case let .searchPhotos(query):
            interactor?.obtainPhotosOnSearch(query: query,
                                             atPage: state.pagination.currentPage + 1,
                                             perPage: state.pagination.perPage)
        }
    }
    
}

// MARK: PhotosCollectionInteractorOutput

extension PhotosCollectionPresenter: PhotosCollectionInteractorOutput {
    
    func didObtain(photos: [UnsplashPhoto],
                   atPage page: Int,
                   withError error: PhotosCollectionProvider.Error?) {
        state.isRequesting = false
        
        guard error == nil else {
            switch error! {
            case .noInternetConnection:
                break
            case .noMorePhotos:
                state.hasMorePhotos = false
            case .internal:
                break
            }
            view?.hideBottomLoading()
            return
        }
        
        state.pagination.currentPage = page
        
        state.photos.append(contentsOf: photos)
        
        updateView(with: photos)
    }
    
    func didUpdateProgress(photoID: String, progress: Double) {
        guard let index = state.photos.index(where: {
            $0.id == photoID
        }) else {
            return
        }
        
        if progress == 1.0 {
            view?.setDownloadState(atIndex: index)
        } else {
            view?.updateDownloadingStateOfPhoto(atIndex: index, progress: progress)
        }
    }
    
    func didDownload(photoID: String, image: UIImage?, withError error: Error?) {
        guard let index = state.photos.index(where: {
            $0.id == photoID
        }) else {
            return
        }
        
        if let image = image {
            save(image: image)
        }
        
        view?.setDownloadState(atIndex: index)
    }
    
    private func save(image: UIImage) {
        let isAccessOpen = photosPermission.status == .authorized
        
        if isAccessOpen {
            interactor?.save(
                image: image,
                completion: { [weak self] (success, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.moduleOutput?.didSavePhoto(success: success, error: error)
            })
        } else {
            photosPermission.request { [weak self] (status) in
                guard let strongSelf = self else {
                    return
                }
                
                let isOpen = status == .authorized
                
                if isOpen {
                    strongSelf.interactor?.save(
                        image: image,
                        completion: { [weak self] (success, error) in
                            guard let strongSelf = self else {
                                return
                            }
                            strongSelf.moduleOutput?.didSavePhoto(success: success, error: error)
                    })
                } else {
                    
                }
            }
        }
    }
    
}

// MARK: PhotosCollectionModuleInput

extension PhotosCollectionPresenter: PhotosCollectionModuleInput {
    
    func configure(collectionLayout: YouthCollectionLayout, usage: PhotosCollectionUsage) {
        state.collectionLayout = collectionLayout
        state.usage = usage
    }
    
    func set(moduleOutput: PhotosCollectionModuleOutput) {
        self.moduleOutput = moduleOutput
    }
    
    func parentModuleIsReady() {
        view?.setUpInitialState(withCollectionLayout: state.collectionLayout)
        
        view?.showBottomLoading()
        
        state.isRequesting = true
        
        switch state.usage {
        case let .photos(orderBy):
            interactor?.obtainPhotos(atPage: state.pagination.currentPage + 1,
                                     perPage: state.pagination.perPage,
                                     orderBy: orderBy)
        case let .userPhotos(username, orderBy):
            interactor?.obtainUserPhotos(username: username,
                                         atPage: state.pagination.currentPage + 1,
                                         perPage: state.pagination.perPage,
                                         orderBy: orderBy)
        case let .searchPhotos(query):
            interactor?.obtainPhotosOnSearch(query: query,
                                             atPage: state.pagination.currentPage + 1,
                                             perPage: state.pagination.perPage)
        }
    }
    
    func change(layout: YouthCollectionLayout) {
        state.collectionLayout = layout
        view?.changeLayout(layout)
    }
    
    func change(usage: PhotosCollectionUsage) {
        state.usage = usage
        
        view?.updateState(with: [])
        
        view?.showBottomLoading()
        
        state.photos.removeAll()
        state.hasMorePhotos = true
        state.pagination.currentPage = 0
        state.isRequesting = true
        
        switch state.usage {
        case let .photos(orderBy):
            interactor?.obtainPhotos(atPage: state.pagination.currentPage + 1,
                                     perPage: state.pagination.perPage,
                                     orderBy: orderBy)
        case let .userPhotos(username, orderBy):
            interactor?.obtainUserPhotos(username: username,
                                         atPage: state.pagination.currentPage + 1,
                                         perPage: state.pagination.perPage,
                                         orderBy: orderBy)
        case let .searchPhotos(query):
            interactor?.obtainPhotosOnSearch(query: query,
                                             atPage: state.pagination.currentPage + 1,
                                             perPage: state.pagination.perPage)
        }
    }
    
    func set(scrollEnabled: Bool) {
        view?.set(scrollEnabled: scrollEnabled)
    }
    
    func configure(scrollOwner: PhotosCollectionScrollOwner) {
        scrollOwner.photosCollectionScrollingUpdateReceiver = self
    }
    
}

// MARK: Private methods

extension PhotosCollectionPresenter {
    
    private func updateView(with photos: [UnsplashPhoto]) {
        view?.hideBottomLoading()
        
        let models = viewModels(from: photos)
        
        if state.pagination.currentPage <= 1 {
            view?.updateState(with: models)
        } else {
            view?.updateStateByAdding(viewModels: models)
        }
    }
    
    private func viewModels(from photos: [UnsplashPhoto]) -> [PhotosCollectionCellViewModel] {
        var viewModels: [PhotosCollectionCellViewModel] = []
        
        for photo in photos {
            let viewModel = viewModelBuilder.build(fromPhoto: photo)
            viewModels.append(viewModel)
        }
        
        return viewModels
    }
    
}
