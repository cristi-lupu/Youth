//
//  PhotoDetailsViewModel.swift
//  Youth
//
//  Created by Lupu Cristian on 6/12/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// PhotoDetailsViewModel
struct PhotoDetailsViewModel {
    
    /// Photo URL
    let photoURL: URL?
    
    /// Photo background color
    let photoBackgroundColor: UIColor
    
    /// Photo size
    let photoSize: CGSize
    
    /// User view model
    let userViewModel: YouthUserViewModel
    
    /// Location view model
    let locationViewModel: YouthLocationViewModel
    
    /// Exif view model
    let exifViewModel: YouthPhotoExifViewModel
    
}
