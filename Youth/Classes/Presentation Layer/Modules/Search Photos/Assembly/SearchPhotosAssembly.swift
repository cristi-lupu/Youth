//
//  SearchPhotosAssembly.swift
//  Youth
//
//  Created by Cristian Lupu on 01/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class SearchPhotosAssembly {

    func assemblySearchPhotosModule() -> UIViewController {
        let view = SearchPhotosViewController()
        let presenter = SearchPhotosPresenter()
        let router = SearchPhotosRouter()
        let state = SearchPhotosState()
        let interactor = SearchPhotosInteractor()

        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.state = state
        interactor.output = presenter
        router.viewController = view

        return view
    }

}
