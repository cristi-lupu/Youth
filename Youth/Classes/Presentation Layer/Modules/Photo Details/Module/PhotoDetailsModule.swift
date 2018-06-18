//
//  PhotoDetailsModule.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class PhotoDetailsModule {
	
	// MARK: View Controller

	public let viewController: UIViewController

	// MARK: Module Input
	
	public let moduleInput: PhotoDetailsModuleInput

	public required init(viewController: UIViewController, moduleInput: PhotoDetailsModuleInput) {
		self.viewController = viewController
		self.moduleInput = moduleInput
	}

}