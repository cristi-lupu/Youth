//
//  PhotoDetailsViewInput.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public protocol PhotoDetailsViewInput: class {
	
    func setUpInitialState(title: String)

    func updateState(withViewModel viewModel: PhotoDetailsViewModel)

    func showTopLoading()

    func hideTopLoading()

}
