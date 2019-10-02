//
//  UnsplashLocation.swift
//  Youth
//
//  Created by Cristian Lupu on 4/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /// Location. Usually obtained from Unsplash Photo.
    struct Location: Decodable {
        /**
         Location's city
         */
        let city: String?

        /**
         Location's country
         */
        let country: String?

        /**
         Location's position
         */
        let position: Position?

        private enum CodingKeys: String, CodingKey {
            case city
            case country
            case position
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.city = try container.decodeIfPresent(String.self, forKey: .city)
            self.country = try container.decodeIfPresent(String.self, forKey: .country)
            self.position = try container.decodeIfPresent(Position.self, forKey: .position)
        }
    }
}
