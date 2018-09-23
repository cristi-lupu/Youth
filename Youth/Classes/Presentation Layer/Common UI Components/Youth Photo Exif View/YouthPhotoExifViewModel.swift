//
//  YouthPhotoExifViewModel.swift
//  Youth
//
//  Created by Lupu Cristian on 6/16/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

struct YouthPhotoExifViewModel {
    
    /// Photo dimension. Like 3444 * 1222
    let photoDimensions: String
    
    /// Camera Model
    let cameraModel: String
    
    /// Focal length
    let focalLength: String
    
    /// Aperture
    let aperture: String
    
    /// Exposure Time
    let exposureTime: String
    
    /// ISO
    let iso: String
    
    /// If does not contain anything return false, otherwise true
    var isEmpty: Bool {
        return photoDimensions.isEmpty
            && cameraModel.isEmpty
            && focalLength.isEmpty
            && aperture.isEmpty
            && exposureTime.isEmpty
            && iso.isEmpty
    }
    
}
