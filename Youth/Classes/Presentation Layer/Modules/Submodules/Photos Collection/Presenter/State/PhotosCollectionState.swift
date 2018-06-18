//
//  PhotosCollectionState.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public struct PhotosCollectionState {

    /// Pagination struct
    public struct Pagination {

        /// Current Page. Default value: 0
        public var currentPage = 0

        /// Per page. Default value: 30
        public let perPage = 30

    }

    /// Collection Layout. Default value: .grid
    public var collectionLayout: YouthCollectionLayout = .grid

    /// Usage. Default value: .latest
    public var usage: PhotosCollectionUsage = .photos(orderBy: .latest)

    /// Pagination
    public var pagination = Pagination()

    /// Has more photos
    public var hasMorePhotos = true

    /// Photos models
    public var photos: [UnsplashPhoto] = []

    /// Is requesting state. Default value: false
    public var isRequesting = false
    
}
