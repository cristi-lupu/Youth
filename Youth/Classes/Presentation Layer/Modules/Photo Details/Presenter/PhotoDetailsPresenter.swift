//
//  PhotoDetailsPresenter.swift
//  Youth
//
//  Created by Cristian Lupu on 10/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotoDetailsPresenter {
    
    // MARK: View
    
    weak var view: PhotoDetailsViewInput?
    
    // MARK: Interactor
    
    var interactor: PhotoDetailsInteractorInput?
    
    // MARK: Router
    
    var router: PhotoDetailsRouterInput?
    
    // MARK: State
    
    var state = PhotoDetailsState()
    
    // MARK: Private properties
    
    private let viewModelBuilder: PhotoDetailsViewModelBuilder
    
    init(viewModelBuilder: PhotoDetailsViewModelBuilder) {
        self.viewModelBuilder = viewModelBuilder
    }
    
}

// MARK: PhotoDetailsViewOutput

extension PhotoDetailsPresenter: PhotoDetailsViewOutput {
    
    func viewIsReady() {
        guard let id = state.photo?.id else {
            return
        }
        
        view?.setUpInitialState(title: "Photo")
        
        view?.showTopLoading()
        
        interactor?.obtainPhoto(withID: id)
    }
    
    func didTapUser() {
        guard let user = state.photo?.user else {
            return
        }
        
        router?.showUserProfile(withUser: user)
    }
    
}

// MARK: PhotoDetailsInteractorOutput

extension PhotoDetailsPresenter: PhotoDetailsInteractorOutput {
    
    func didObtain(photo: UnsplashPhoto?, withError error: PhotoProvider.Error?) {
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
    
    func configure(withPhoto photo: UnsplashPhoto) {
        state.photo = photo
    }
    
}
