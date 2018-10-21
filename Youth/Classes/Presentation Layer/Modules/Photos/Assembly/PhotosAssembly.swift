//
//  PhotosAssembly.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotosAssembly {

    func assemblyPhotosModule() -> UIViewController {
        let view = PhotosViewController()
        let presenter = PhotosPresenter()
        let router = PhotosRouter()
        let state = PhotosState()
        let interactor = PhotosInteractor()

        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.state = state
        interactor.output = presenter
        router.viewController = view

        return YouthNavigationController(initialViewController: view)
    }

}
