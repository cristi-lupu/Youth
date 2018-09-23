//
//  PhotosViewOutput.swift
//  Youth
//
//  Created by Lupu Cristian on 09/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

protocol PhotosViewOutput: class {
    
	func viewIsReady()

    func didTapSearchButton()

    func didTapLayoutButton()

    func didChangePhotosCategory(at index: Int)

}
