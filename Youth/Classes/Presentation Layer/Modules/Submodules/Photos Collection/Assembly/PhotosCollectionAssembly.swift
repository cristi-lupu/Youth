//
//  PhotosCollectionAssembly.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit
import Alamofire
import Permission

public final class PhotosCollectionAssembly {

    public func assemblyPhotosCollectionModule(scrollOwner: PhotosCollectionScrollOwner? = nil) -> PhotosCollectionModule {
		let view = PhotosCollectionView(frame: CGRect.zero,
                                        collectionViewLayout: UICollectionViewFlowLayout())

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

        let networkClient = UnsplashNetworkClient()
        let photosProvider = PhotosCollectionProvider(networkClient: networkClient)

        let downloader = YouthPhotoDownloader.default
        let photoSaver = YouthPhotoSaver()

		let interactor = PhotosCollectionInteractor(networkReachability: reachability,
                                                    photosProvider: photosProvider,
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
