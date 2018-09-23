//
//  UserProfileAssembly.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class UserProfileAssembly {
    
    func assemblyUserProfileModule() -> UserProfileModule {
        let view = UserProfileViewController()
        
        let fullNameFormatter = FullNameFormatter()
        let usernameFormatter = UsernameFormatter()
        
        let userViewModelBuilder = YouthUserViewModelBuider(fullNameFormatter: fullNameFormatter,
                                                            usernameFormatter: usernameFormatter)
        
        let locationViewModelBuilder = YouthLocationViewModelBuilder()
        
        let shortNumberFormatter = ShortNumberFormatter()
        
        let viewModelBuilder = UserProfileViewModelBuilder(userViewModelBuider: userViewModelBuilder,
                                                           locationViewModelBuilder: locationViewModelBuilder,
                                                           shortNumberFormatter: shortNumberFormatter)
        
        let presenter = UserProfilePresenter(viewModelBuilder: viewModelBuilder)
        
        let router = UserProfileRouter()
        let state = UserProfileState()
        let interactor = UserProfileInteractor()
        
        let instagramOpener = InstagramAppOpener()
        let twitterOpener = TwitterAppOpener()
        
        interactor.instagramOpener = instagramOpener
        interactor.twitterOpener = twitterOpener
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.state = state
        interactor.output = presenter
        router.viewController = view
        
        return UserProfileModule(viewController: view, moduleInput: presenter)
    }
    
}
