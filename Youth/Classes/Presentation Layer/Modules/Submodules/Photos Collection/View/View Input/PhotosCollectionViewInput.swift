//
//  PhotosCollectionViewInput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotosCollectionViewInput: class {
    
    func setUpInitialState(withCollectionLayout layout: YouthCollectionLayout)
    
    func updateState(with viewModels: [PhotosCollectionCellViewModel])
    
    func updateStateByAdding(viewModels: [PhotosCollectionCellViewModel])
    
    func changeLayout(_ layout: YouthCollectionLayout)
    
    func set(scrollEnabled: Bool)
    
    func showBottomLoading()
    
    func hideBottomLoading()
    
    func updateDownloadingStateOfPhoto(atIndex index: Int, progress: Double)
    
    func setDownloadState(atIndex index: Int)
    
}
