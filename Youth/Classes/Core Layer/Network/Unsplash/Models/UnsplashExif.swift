//
//  UnsplashExif.swift
//  Youth
//
//  Created by Cristian Lupu on 4/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /// Photo Metadata
    struct Exif: Decodable {
        /**
         Camera’s brand
         */
        let make: String?

        /**
         Camera’s model
         */
        let model: String?

        /**
         Camera’s exposure time
         */
        let exposureTime: String?

        /**
         Camera’s aperture value
         */
        let aperture: String?

        /**
         Camera’s focal length
         */
        let focalLength: String?

        /**
         Camera’s iso
         */
        let iso: Int?

        private enum CodingKeys: String, CodingKey {
            case make
            case model
            case exposureTime = "exposure_time"
            case aperture
            case focalLength = "focal_length"
            case iso
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.make = try container.decodeIfPresent(String.self, forKey: .make)
            self.model = try container.decodeIfPresent(String.self, forKey: .model)
            self.exposureTime = try container.decodeIfPresent(String.self, forKey: .exposureTime)
            self.aperture = try container.decodeIfPresent(String.self, forKey: .aperture)
            self.focalLength = try container.decodeIfPresent(String.self, forKey: .focalLength)
            self.iso = try container.decodeIfPresent(Int.self, forKey: .iso)
        }
    }
}
