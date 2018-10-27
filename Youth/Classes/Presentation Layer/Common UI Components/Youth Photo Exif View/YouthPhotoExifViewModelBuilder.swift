//
//  YouthPhotoExifViewModelBuilder.swift
//  Youth
//
//  Created by Cristian Lupu on 6/16/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to build YouthPhotoExifViewModel
final class YouthPhotoExifViewModelBuilder {
    /**
     Build YouthPhotoExifViewModel.

     - parameter exif: Exif in `optional` UnsplashExif format
     - parameter photoWidth: `Optional` photo width
     - parameter photoHeight: `Optional` photo height

     - returns: Builded YouthPhotoExifViewModel
     */

    // swiftlint:disable:next cyclomatic_complexity
    func build(fromExif exif: Unsplash.Exif?,
               photoWidth: Int?,
               photoHeight: Int?) -> YouthPhotoExifViewModel {
        guard let exif = exif else {
            return YouthPhotoExifViewModel(photoDimensions: "",
                                           cameraModel: "",
                                           focalLength: "",
                                           aperture: "",
                                           exposureTime: "",
                                           iso: "")
        }

        let defaultValue = "- - -"

        let dimensions: String

        if let width = photoWidth, let height = photoHeight {
            dimensions = "\(width) x \(height)"
        } else {
            dimensions = defaultValue
        }

        var cameraModel = ""

        if let make = exif.make {
            cameraModel = make
        }

        if let model = exif.model {
            if cameraModel.isEmpty {
                cameraModel = model
            } else {
                if model.hasPrefix(cameraModel) {
                    cameraModel = model
                } else {
                    cameraModel += " \(model)"
                }
            }
        }

        if cameraModel.isEmpty {
            cameraModel = defaultValue
        }

        let focalLength: String

        if let length = exif.focalLength {
            focalLength = length + " mm"
        } else {
            focalLength = defaultValue
        }

        let aperture: String

        // swiftlint:disable:next identifier_name
        if let _aperture = exif.aperture {
            aperture = "ʄ/" + _aperture
        } else {
            aperture = defaultValue
        }

        let exposureTime: String

        if let time = exif.exposureTime {
            exposureTime = time + " s"
        } else {
            exposureTime = defaultValue
        }

        let iso: String

        // swiftlint:disable:next identifier_name
        if let _iso = exif.iso {
            iso = String(_iso)
        } else {
            iso = defaultValue
        }

        return YouthPhotoExifViewModel(photoDimensions: dimensions,
                                       cameraModel: cameraModel,
                                       focalLength: focalLength,
                                       aperture: aperture,
                                       exposureTime: exposureTime,
                                       iso: iso)
    }
}
