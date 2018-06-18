//
//  UserProfileModule.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public final class UserProfileModule {
	
	// MARK: View Controller
	public let viewController: UIViewController

	// MARK: Module Input
	public let moduleInput: UserProfileModuleInput

	public required init(viewController: UIViewController, moduleInput: UserProfileModuleInput) {
		self.viewController = viewController
		self.moduleInput = moduleInput
	}

}