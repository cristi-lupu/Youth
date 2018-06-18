//
//  PhotoDetailsViewModel.swift
//  Youth
//
//  Created by Lupu Cristian on 6/12/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// PhotoDetailsViewModel
public struct PhotoDetailsViewModel {

    /// Photo URL
    public let photoURL: URL?

    /// Photo background color
    public let photoBackgroundColor: UIColor

    /// Photo size
    public let photoSize: CGSize

    /// User view model
    public let userViewModel: YouthUserViewModel

    /// Location view model
    public let locationViewModel: YouthLocationViewModel

    /// Exif view model
    public let exifViewModel: YouthPhotoExifViewModel

}
