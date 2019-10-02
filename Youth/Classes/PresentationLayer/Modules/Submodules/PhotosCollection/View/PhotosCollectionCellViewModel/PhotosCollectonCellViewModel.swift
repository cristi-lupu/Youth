//
//  PhotosCollectonCellViewModel.swift
//  Youth
//
//  Created by Cristian Lupu on 5/12/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// PhotosCollectionCellViewModel
struct PhotosCollectionCellViewModel {

    /// Original photo size
    let originalPhotoSize: CGSize

    /// Image Background Color
    let backgroundColor: UIColor

    /// Likes Count
    let likes: String

    /// Is liked By User
    let likedByUser: Bool

    /// Image URL
    let imageURL: URL?

    /// User View Model
    let userViewModel: YouthUserViewModel

    /// Is Downloading
    var isDownloading = false

    /// Downloading progress
    var downloadingProgress: Double = 0.0

    init(originalPhotoSize: CGSize,
         backgroundColor: UIColor,
         likes: String,
         likedByUser: Bool,
         imageURL: URL?,
         userViewModel: YouthUserViewModel) {
        self.originalPhotoSize = originalPhotoSize
        self.backgroundColor = backgroundColor
        self.likes = likes
        self.likedByUser = likedByUser
        self.imageURL = imageURL
        self.userViewModel = userViewModel
    }

}
