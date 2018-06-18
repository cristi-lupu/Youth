//
//  PhotoViewerModule.swift
//  Youth
//
//  Created by Lupu Cristian on 16/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotoViewerModule {
	
	// MARK: View Controller

	public let viewController: UIViewController

	// MARK: Module Input
	
	public let moduleInput: PhotoViewerModuleInput

	public required init(viewController: UIViewController, moduleInput: PhotoViewerModuleInput) {
		self.viewController = viewController
		self.moduleInput = moduleInput
	}

}