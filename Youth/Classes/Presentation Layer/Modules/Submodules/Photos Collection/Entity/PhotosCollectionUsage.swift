//
//  PhotosCollectionUsage.swift
//  Youth
//
//  Created by Cristian Lupu on 5/11/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

enum PhotosCollectionUsage {
    case photos(orderBy: Unsplash.PhotosOrderBy)
    case userPhotos(username: String, orderBy: Unsplash.PhotosOrderBy)
    case searchPhotos(query: String)
}
