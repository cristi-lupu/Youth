//
//  YouthPhotoExifViewModel.swift
//  Youth
//
//  Created by Lupu Cristian on 6/16/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public struct YouthPhotoExifViewModel {

    /// Photo dimension. Like 3444 * 1222
    public let photoDimensions: String

    /// Camera Model
    public let cameraModel: String

    /// Focal length
    public let focalLength: String

    /// Aperture
    public let aperture: String

    /// Exposure Time
    public let exposureTime: String

    /// ISO
    public let iso: String

    /// If does not contain anything return false, otherwise true
    public var isEmpty: Bool {
        return photoDimensions.isEmpty && cameraModel.isEmpty && focalLength.isEmpty && aperture.isEmpty && exposureTime.isEmpty && iso.isEmpty
    }

}
