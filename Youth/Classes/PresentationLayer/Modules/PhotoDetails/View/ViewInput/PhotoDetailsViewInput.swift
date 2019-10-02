//
//  PhotoDetailsViewInput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotoDetailsViewInput: class {

    func setUpInitialState(title: String)

    func updateState(withViewModel viewModel: PhotoDetailsViewModel)

    func showTopLoading()

    func hideTopLoading()

}
