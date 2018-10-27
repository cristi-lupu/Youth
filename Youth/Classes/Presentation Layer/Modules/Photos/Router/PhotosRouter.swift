//
//  PhotosRouter.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import SnapKit
import UIKit

final class PhotosRouter: PhotosRouterInput {
    weak var viewController: UIViewController?

    // swiftlint:disable:next identifier_name
    private(set) var photosCollectionSubModuleOnParentModuleReady: (() -> Void)?
    private(set) var photosCollectionSubModuleOnLayoutChange: ((YouthCollectionLayout) -> Void)?
    private(set) var photosCollectionSubModuleOnUsageChange: ((PhotosCollectionUsage) -> Void)?

    func closeModule() {
        viewController?.dismiss(animated: true)
    }

    func addPhotosCollectionSubmodule(on canvasView: UIView,
                                      layout: YouthCollectionLayout,
                                      usage: PhotosCollectionUsage,
                                      subModuleOutput: PhotosCollectionModuleOutput) {
        let photosCollectionAssembly = PhotosCollectionAssembly()
        let photosCollectionModule = photosCollectionAssembly.assemblyPhotosCollectionModule()

        let subModuleInput = photosCollectionModule.moduleInput
        subModuleInput.configure(collectionLayout: layout, usage: usage)
        subModuleInput.set(moduleOutput: subModuleOutput)

        photosCollectionSubModuleOnParentModuleReady = { [weak subModuleInput] in
            guard let strongSubModuleInput = subModuleInput else {
                return
            }

            strongSubModuleInput.parentModuleIsReady()
        }

        photosCollectionSubModuleOnLayoutChange = { [weak subModuleInput] collectionLayout in
            guard let strongSubModuleInput = subModuleInput else {
                return
            }

            strongSubModuleInput.change(layout: collectionLayout)
        }

        photosCollectionSubModuleOnUsageChange = { [weak subModuleInput] usage in
            guard let strongSubModuleInput = subModuleInput else {
                return
            }

            strongSubModuleInput.change(usage: usage)
        }

        let subModuleView = photosCollectionModule.view
        canvasView.addSubview(subModuleView)

        subModuleView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    func showUserProfile(withUser user: Unsplash.User) {
        guard let navigationController = viewController?.navigationController else {
            return
        }

        let userProfileAssembly = UserProfileAssembly()
        let userProfileModule = userProfileAssembly.assemblyUserProfileModule()

        userProfileModule.moduleInput.configure(withUser: user)

        navigationController.pushViewController(userProfileModule.viewController, animated: true)
    }

    func showSearchPhotos() {
        guard let navigationController = viewController?.navigationController else {
            return
        }

        let searchPhotosAssembly = SearchPhotosAssembly()
        let searchPhotosViewController = searchPhotosAssembly.assemblySearchPhotosModule()

        navigationController.pushViewController(searchPhotosViewController, animated: true)
    }

    func showPhotoDetails(withPhoto photo: Unsplash.Photo) {
        guard let navigationController = viewController?.navigationController else { return }
        let photoDetailsAssembly = PhotoDetailsAssembly()
        let photoDetailsModule = photoDetailsAssembly.assemblyPhotoDetailsModule()
        photoDetailsModule.moduleInput.configure(withPhoto: photo)
        navigationController.pushViewController(photoDetailsModule.viewController, animated: true)
    }
}
