//
//  UserProfilePresenter.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class UserProfilePresenter {
    
    // MARK: View
    
    weak var view: UserProfileViewInput?
    
    // MARK: Interactor
    
    var interactor: UserProfileInteractorInput?
    
    // MARK: Router
    
    var router: UserProfileRouterInput?
    
    // MARK: State
    
    var state = UserProfileState()
    
    // MARK: View Model Builder
    
    private let viewModelBuider: UserProfileViewModelBuilder
    
    init(viewModelBuilder: UserProfileViewModelBuilder) {
        self.viewModelBuider = viewModelBuilder
    }
    
}

// MARK: UserProfileViewOutput

extension UserProfilePresenter: UserProfileViewOutput {
    
    func viewIsReady() {
        guard let view = view,
            let user = state.user,
            let username = user.username else {
                return
        }
        
        view.setUpInitialState(withViewModel: viewModelBuider.build(withUser: user))
        
        router?.addPhotosCollectionSubmodule(on: view.photosCollectionCanvasView(),
                                             layout: .grid,
                                             usage: .userPhotos(username: username,
                                                                orderBy: .latest),
                                             scrollEnabled: false,
                                             scrollOwner: view.photosCollectionScrollOwner(),
                                             subModuleOutput: self)
        
        defer {
            router?.photosCollectionSubModuleOnParentModuleReady?()
        }
    }
    
    func didTouchUpInsideInstagramButton() {
        guard let instagramUsername = state.user?.instagramUsername else {
            return
        }
        
        interactor?.openInstagramUserProfile(username: instagramUsername)
    }
    
    func didTouchUpInsideTwitterButton() {
        guard let twitterUsername = state.user?.twitterUsername else {
            return
        }
        
        interactor?.openTwitterUserProfile(username: twitterUsername)
    }
    
}

// MARK: UserProfileInteractorOutput

extension UserProfilePresenter: UserProfileInteractorOutput {
    
}

// MARK: UserProfileModuleInput

extension UserProfilePresenter: UserProfileModuleInput {
    
    func configure(withUser user: UnsplashUser) {
        state.user = user
    }
    
}

extension UserProfilePresenter: PhotosCollectionModuleOutput {
    
    func didSelectPhoto(_ photo: UnsplashPhoto) {
        router?.showPhotoDetails(withPhoto: photo)
    }
    
    func didSelectUser(_ user: UnsplashUser) {}
    
    func didSavePhoto(success: Bool, error: Error?) {}
    
    func didChangePhotosCollectionContentHeight(_ height: CGFloat) {
        view?.updatePhotosCollectionCanvasViewHeight(height)
    }
    
}
