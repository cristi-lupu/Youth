//
//  PhotoDetailsViewModelBuilder.swift
//  Youth
//
//  Created by Cristian Lupu on 6/15/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Responsible to build PhotoDetailsViewModel
final class PhotoDetailsViewModelBuilder {
    
    private let userViewModelBuilder: YouthUserViewModelBuider
    private let locationViewModelBuilder: YouthLocationViewModelBuilder
    private let exifViewModelBuilder: YouthPhotoExifViewModelBuilder
    
    /**
     Initialize builder
     
     - parameter userViewModelBuilder: User View Model Builder
     - parameter locationViewModelBuilder: Location View Model Builder
     - parameter exifViewModelBuilder: Exif View Model Builder
     */
    init(userViewModelBuilder: YouthUserViewModelBuider,
         locationViewModelBuilder: YouthLocationViewModelBuilder,
         exifViewModelBuilder: YouthPhotoExifViewModelBuilder) {
        self.userViewModelBuilder = userViewModelBuilder
        self.locationViewModelBuilder = locationViewModelBuilder
        self.exifViewModelBuilder = exifViewModelBuilder
    }
    
    /**
     Build PhotoDetailsViewModel
     
     - parameter photo: Photo object
     
     - returns: Builded PhotoDetailsViewModel
     */
    func build(withPhoto photo: UnsplashPhoto) -> PhotoDetailsViewModel {
        let photoURL: URL?
        
        if let url = photo.imageURLs?.regular {
            photoURL = url
        } else if let url = photo.imageURLs?.small {
            photoURL = url
        } else if let url = photo.imageURLs?.thumb {
            photoURL = url
        } else {
            photoURL = nil
        }
        
        let photoSize: CGSize
        
        if let width = photo.width, let height = photo.height {
            photoSize = CGSize(width: width, height: height)
        } else {
            photoSize = .zero
        }
        
        let userViewModel = userViewModelBuilder.build(withUser: photo.user)
        
        let locationViewModel = locationViewModelBuilder.build(withLocation: photo.location)
        
        let exifViewModel = exifViewModelBuilder.build(fromExif: photo.exif,
                                                       photoWidth: photo.width,
                                                       photoHeight: photo.height)
        
        let photoBackgroundColor: UIColor
        
        if let hex = photo.hexColor {
            photoBackgroundColor = UIColor(hex,
                                           defaultColor: .lightGray)
        } else {
            photoBackgroundColor = .lightGray
        }
        
        return PhotoDetailsViewModel(photoURL: photoURL,
                                     photoBackgroundColor: photoBackgroundColor,
                                     photoSize: photoSize,
                                     userViewModel: userViewModel,
                                     locationViewModel: locationViewModel,
                                     exifViewModel: exifViewModel)
    }
    
}
