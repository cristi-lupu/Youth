//
//  PhotosCollectionCellViewModelBuilder.swift
//  Youth
//
//  Created by Cristian Lupu on 6/17/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Responsible to build PhotosCollectionCellViewModel
final class PhotosCollectionCellViewModelBuilder {
    private let userViewModelBuilder: YouthUserViewModelBuider
    private let shortNumberFormatter: ShortNumberFormatter

    /**
     Initialize builder
     
     - parameter userViewModelBuilder: User view model builder
     - parameter shortNumberFormatter: Short number formatter
     */
    init(userViewModelBuilder: YouthUserViewModelBuider,
         shortNumberFormatter: ShortNumberFormatter) {
        self.userViewModelBuilder = userViewModelBuilder
        self.shortNumberFormatter = shortNumberFormatter
    }

    /**
     Build PhotosCollectionCellViewModel
     
     - parameter photo: Photo object
     
     - returns: Builded PhotosCollectionCellViewModel
     */
    func build(fromPhoto photo: Unsplash.Photo) -> PhotosCollectionCellViewModel {
        let userViewModel = userViewModelBuilder.build(withUser: photo.user)

        var imageSize = CGSize.zero

        if let width = photo.width, let height = photo.height {
            imageSize = CGSize(width: width, height: height)
        }

        let imageURL: URL?

        if let url = photo.imageURLs?.regular {
            imageURL = url
        } else if let url = photo.imageURLs?.small {
            imageURL = url
        } else if let url = photo.imageURLs?.thumb {
            imageURL = url
        } else {
            imageURL = nil
        }

        let likes: String

        // swiftlint:disable:next identifier_name
        if let _likes = photo.likes {
            likes = shortNumberFormatter.string(from: _likes)
        } else {
            likes = "0"
        }

        let backgroundColor: UIColor

        if let color = photo.hexColor {
            backgroundColor = UIColor(color, defaultColor: .lightGray)
        } else {
            backgroundColor = .lightGray
        }

        var likedByUser = false

        if let liked = photo.likedByUser {
            likedByUser = liked
        }

        return PhotosCollectionCellViewModel(originalPhotoSize: imageSize,
                                             backgroundColor: backgroundColor,
                                             likes: likes,
                                             likedByUser: likedByUser,
                                             imageURL: imageURL,
                                             userViewModel: userViewModel)
    }
}
