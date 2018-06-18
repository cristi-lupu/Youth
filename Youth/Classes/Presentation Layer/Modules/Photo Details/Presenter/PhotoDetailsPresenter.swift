//
//  PhotoDetailsPresenter.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotoDetailsPresenter {
    
    // MARK: View
    
    public weak var view: PhotoDetailsViewInput?

    // MARK: Interactor

    public var interactor: PhotoDetailsInteractorInput?

    // MARK: Router

    public var router: PhotoDetailsRouterInput?

    // MARK: State

    public var state = PhotoDetailsState()

    // MARK: Private properties

    private let viewModelBuilder: PhotoDetailsViewModelBuilder

    public init(viewModelBuilder: PhotoDetailsViewModelBuilder) {
        self.viewModelBuilder = viewModelBuilder
    }
    
}

// MARK: PhotoDetailsViewOutput

extension PhotoDetailsPresenter: PhotoDetailsViewOutput {
    
    public func viewIsReady() {
        guard let id = state.photo?.id else {
            return
        }

        view?.setUpInitialState(title: "Photo")
        
        view?.showTopLoading()

        interactor?.obtainPhoto(withID: id)
    }

    public func didTapUser() {
        guard let user = state.photo?.user else {
            return
        }

        router?.showUserProfile(withUser: user)
    }
    
}

// MARK: PhotoDetailsInteractorOutput

extension PhotoDetailsPresenter: PhotoDetailsInteractorOutput {

    public func didObtain(photo: UnsplashPhoto?, withError error: PhotoProvider.Error?) {
        view?.hideTopLoading()

        guard let photo = photo else {
            print(error!)
            return
        }

        let viewModel = viewModelBuilder.build(withPhoto: photo)
        view?.updateState(withViewModel: viewModel)
    }
    
}

// MARK: PhotoDetailsModuleInput

extension PhotoDetailsPresenter: PhotoDetailsModuleInput {

    public func configure(withPhoto photo: UnsplashPhoto) {
        state.photo = photo
    }
    
}
