//
//  UserProfilePresenter.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class UserProfilePresenter {
    
    // MARK: View
    
    public weak var view: UserProfileViewInput?

    // MARK: Interactor

    public var interactor: UserProfileInteractorInput?

    // MARK: Router

    public var router: UserProfileRouterInput?

    // MARK: State

    public var state = UserProfileState()

    // MARK: View Model Builder

    private let viewModelBuider: UserProfileViewModelBuilder

    public init(viewModelBuilder: UserProfileViewModelBuilder) {
        self.viewModelBuider = viewModelBuilder
    }
    
}

// MARK: UserProfileViewOutput

extension UserProfilePresenter: UserProfileViewOutput {
    
    public func viewIsReady() {
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

    public func didTouchUpInsideInstagramButton() {
        guard let instagramUsername = state.user?.instagramUsername else {
            return
        }

        interactor?.openInstagramUserProfile(username: instagramUsername)
    }

    public func didTouchUpInsideTwitterButton() {
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

    public func configure(withUser user: UnsplashUser) {
        state.user = user
    }
    
}

extension UserProfilePresenter: PhotosCollectionModuleOutput {

    public func didSelectPhoto(_ photo: UnsplashPhoto) {
        router?.showPhotoDetails(withPhoto: photo)
    }

    public func didSelectUser(_ user: UnsplashUser) {}

    public func didSavePhoto(success: Bool, error: Error?) {}

    public func didChangePhotosCollectionContentHeight(_ height: CGFloat) {
        view?.updatePhotosCollectionCanvasViewHeight(height)
    }

}
