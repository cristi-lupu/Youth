//
//  PhotosCollectionModule.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class PhotosCollectionModule {
    
    // MARK: View
    
    let view: UIView
    
    // MARK: Module Input
    
    let moduleInput: PhotosCollectionModuleInput
    
    required init(view: UIView, moduleInput: PhotosCollectionModuleInput) {
        self.view = view
        self.moduleInput = moduleInput
    }
    
}
