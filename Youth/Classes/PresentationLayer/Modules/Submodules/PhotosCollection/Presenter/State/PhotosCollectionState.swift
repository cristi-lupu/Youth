//
//  PhotosCollectionState.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

struct PhotosCollectionState {
    /// Pagination struct
    struct Pagination {
        /// Current Page. Default value: 0
        var currentPage = 0

        /// Per page. Default value: 30
        let perPage = 30
    }

    /// Collection Layout. Default value: .grid
    var collectionLayout: YouthCollectionLayout = .grid

    /// Usage. Default value: .latest
    var usage: PhotosCollectionUsage = .photos(orderBy: .latest)

    /// Pagination
    var pagination = Pagination()

    /// Has more photos
    var hasMorePhotos = true

    /// Photos models
    var photos: [Unsplash.Photo] = []

    /// Is requesting state. Default value: false
    var isRequesting = false
}
