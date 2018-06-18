//
//  SearchPhotosViewOutput.swift
//  Youth
//
//  Created by Lupu Cristian on 01/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public protocol SearchPhotosViewOutput: class {
    
	func viewIsReady()

    func viewDidAppear()

    func didTapLayoutButton()

    func didChange(searchText: String)

}
