//
//  PhotoViewerRouter.swift
//  Youth
//
//  Created by Lupu Cristian on 16/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotoViewerRouter {
	
	public weak var viewController: UIViewController?

}

extension PhotoViewerRouter: PhotoViewerRouterInput {
	
	public func closeModule() {
		viewController?.dismiss(animated: true)
	}

}