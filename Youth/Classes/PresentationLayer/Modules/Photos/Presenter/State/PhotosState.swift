//
//  PhotosState.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

struct PhotosState {

    /// Collection Layout. Default value .list
    var collectionLayout: YouthCollectionLayout = .list

    /// Photos Category. Default value .latest
    var photosCategory: PhotosCategoryType = .latest

    /// Photos Categories Current Index. Default value 0
    var photosCategoriesCurrentIndex = 0

}
