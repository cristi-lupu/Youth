//
//  SearchPhotosViewOutput.swift
//  Youth
//
//  Created by Cristian Lupu on 01/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol SearchPhotosViewOutput: class {
    
    func viewIsReady()
    
    func viewDidAppear()
    
    func didTapLayoutButton()
    
    func didChange(searchText: String)
    
}
