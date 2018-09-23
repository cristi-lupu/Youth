//
//  SearchPhotosViewInput.swift
//  Youth
//
//  Created by Lupu Cristian on 01/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

protocol SearchPhotosViewInput: class {
    
    func setUpInitialState(collectionLayout: YouthCollectionLayout)
    
    func updateState(for collectionLayout: YouthCollectionLayout)
    
    func showKeyboard()
    
    func photosCollectionCanvasView() -> UIView
    
    func showNotification(withText text: String)
    
}
