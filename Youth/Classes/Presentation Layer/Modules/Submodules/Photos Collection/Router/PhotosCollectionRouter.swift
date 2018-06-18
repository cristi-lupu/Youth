//
//  PhotosCollectionRouter.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotosCollectionRouter {
	
	public weak var view: UIView?

}

extension PhotosCollectionRouter: PhotosCollectionRouterInput {
	
	public func closeModule() {
		view?.removeFromSuperview()
	}

}
