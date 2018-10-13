//
//  PhotosCollectionModuleInput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotosCollectionModuleInput: class {
    
    func configure(collectionLayout: YouthCollectionLayout, usage: PhotosCollectionUsage)
    
    func set(moduleOutput: PhotosCollectionModuleOutput)
    
    func parentModuleIsReady()
    
    func change(layout: YouthCollectionLayout)
    
    func change(usage: PhotosCollectionUsage)
    
    func set(scrollEnabled: Bool)
    
    func configure(scrollOwner: PhotosCollectionScrollOwner)
    
}
