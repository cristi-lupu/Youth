//
//  PhotosCollectionModuleInput.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public protocol PhotosCollectionModuleInput: class {

    func configure(collectionLayout: YouthCollectionLayout, usage: PhotosCollectionUsage)

    func set(moduleOutput: PhotosCollectionModuleOutput)

    func parentModuleIsReady()

    func change(layout: YouthCollectionLayout)

    func change(usage: PhotosCollectionUsage)

    func set(scrollEnabled: Bool)

    func configure(scrollOwner: PhotosCollectionScrollOwner)
	
}
