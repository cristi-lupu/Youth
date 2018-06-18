//
//  PhotosCollectionModule.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotosCollectionModule {
	
	// MARK: View

	public let view: UIView

	// MARK: Module Input

	public let moduleInput: PhotosCollectionModuleInput

	public required init(view: UIView, moduleInput: PhotosCollectionModuleInput) {
		self.view = view
		self.moduleInput = moduleInput
	}

}
