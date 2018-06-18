//
//  PhotosCollectonCellViewModel.swift
//  Youth
//
//  Created by Lupu Cristian on 5/12/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// PhotosCollectionCellViewModel
public struct PhotosCollectionCellViewModel {

    /// Original photo size
    public let originalPhotoSize: CGSize

    /// Image Background Color
    public let backgroundColor: UIColor

    /// Likes Count
    public let likes: String

    /// Is liked By User
    public let likedByUser: Bool

    /// Image URL
    public let imageURL: URL?

    /// User View Model
    public let userViewModel: YouthUserViewModel

    /// Is Downloading
    public var isDownloading = false

    /// Downloading progress
    public var downloadingProgress: Double = 0.0

    public init(originalPhotoSize: CGSize,
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
