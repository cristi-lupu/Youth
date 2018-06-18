//
//  PhotoViewerAssembly.swift
//  Youth
//
//  Created by Lupu Cristian on 16/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotoViewerAssembly {

	public func assemblyPhotoViewerModule() -> PhotoViewerModule {
		let view = PhotoViewerViewController()
		let presenter = PhotoViewerPresenter()
		let router = PhotoViewerRouter()
		let state = PhotoViewerState()
		let interactor = PhotoViewerInteractor()

		view.output = presenter
		presenter.view = view
		presenter.interactor = interactor
		presenter.router = router
		presenter.state = state
		interactor.output = presenter
		router.viewController = view

		return PhotoViewerModule(viewController: view, moduleInput: presenter)
	}

}