//
//  UnsplashLocation.swift
//  Youth
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Location. Usually obtained from Unsplash Photo.
struct UnsplashLocation {
    
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
    let position: UnsplashPosition?
    
}

// MARK: Decodable

extension UnsplashLocation: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case city
        case country
        case position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.position = try container.decodeIfPresent(UnsplashPosition.self, forKey: .position)
    }
    
}


