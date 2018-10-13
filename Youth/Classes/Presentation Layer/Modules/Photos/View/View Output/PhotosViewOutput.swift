//
//  PhotosViewOutput.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotosViewOutput: class {
    
	func viewIsReady()

    func didTapSearchButton()

    func didTapLayoutButton()

    func didChangePhotosCategory(at index: Int)

}
