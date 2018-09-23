//
//  PhotoDetailsAssembly.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class PhotoDetailsAssembly {
    
    func assemblyPhotoDetailsModule() -> PhotoDetailsModule {
        let view = PhotoDetailsViewController()
        
        let fullNameFormatter = FullNameFormatter()
        let usernameFormatter = UsernameFormatter()
        
        let userViewModelBuilder = YouthUserViewModelBuider(fullNameFormatter: fullNameFormatter,
                                                            usernameFormatter: usernameFormatter)
        
        let locationViewModelBuilder = YouthLocationViewModelBuilder()
        
        let exifViewModelBuilder = YouthPhotoExifViewModelBuilder()
        
        let viewModelBuilder = PhotoDetailsViewModelBuilder(userViewModelBuilder: userViewModelBuilder,
                                                            locationViewModelBuilder: locationViewModelBuilder,
                                                            exifViewModelBuilder: exifViewModelBuilder)
        
        let presenter = PhotoDetailsPresenter(viewModelBuilder: viewModelBuilder)
        
        let router = PhotoDetailsRouter()
        let state = PhotoDetailsState()
        
        let networkClient = UnsplashNetworkClient()
        let photoProvider = PhotoProvider(networkClient: networkClient)
        
        let interactor = PhotoDetailsInteractor(photoProvider: photoProvider)
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.state = state
        interactor.output = presenter
        router.viewController = view
        
        return PhotoDetailsModule(viewController: view, moduleInput: presenter)
    }
    
}
