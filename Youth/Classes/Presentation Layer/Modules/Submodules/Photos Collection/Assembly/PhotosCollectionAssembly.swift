//
//  PhotosCollectionAssembly.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Alamofire
import Permission
import UIKit

final class PhotosCollectionAssembly {

    func assemblyPhotosCollectionModule(scrollOwner: PhotosCollectionScrollOwner? = nil) -> PhotosCollectionModule {
        let view = PhotosCollectionView(frame: .zero,
                                        collectionViewLayout: .init())

        let fullNameFormatter = FullNameFormatter()
        let usernameFormatter = UsernameFormatter()

        let userViewModelBuilder = YouthUserViewModelBuider(fullNameFormatter: fullNameFormatter,
                                                            usernameFormatter: usernameFormatter)

        let shortNumberFormatter = ShortNumberFormatter()

        let viewModelBuilder = PhotosCollectionCellViewModelBuilder(userViewModelBuilder: userViewModelBuilder,
                                                                    shortNumberFormatter: shortNumberFormatter)

        let permission = Permission.photos

        let presenter = PhotosCollectionPresenter(viewModelBuilder: viewModelBuilder, photosPermission: permission)

        let router = PhotosCollectionRouter()
        let state = PhotosCollectionState()

        let reachability = NetworkReachabilityManager()

        let unsplash = Unsplash()

        let downloader = YouthPhotoDownloader.default
        let photoSaver = YouthPhotoSaver()

        let interactor = PhotosCollectionInteractor(networkReachability: reachability,
                                                    unsplash: unsplash,
                                                    photoDownloader: downloader,
                                                    photoSaver: photoSaver)

        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.state = state
        interactor.output = presenter
        router.view = view

        let module = PhotosCollectionModule(view: view, moduleInput: presenter)

        module.moduleInput.configure(scrollOwner: scrollOwner ?? view)

        return module
    }

}
