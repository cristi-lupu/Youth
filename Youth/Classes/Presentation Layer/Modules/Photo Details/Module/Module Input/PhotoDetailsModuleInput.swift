//
//  PhotoDetailsModuleInput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotoDetailsModuleInput: class {
    
    func configure(withPhoto photo: UnsplashPhoto)
    
}
