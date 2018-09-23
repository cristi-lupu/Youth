//
//  UnsplashPosition.swift
//  Youth
//
//  Created by Lupu Cristian on 5/9/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Position. See Unsplash Location
struct UnsplashPosition {
    
    /**
     Location's latitude
     */
    let latitude: Double?
    
    /**
     Location's longitude
     */
    let longitude: Double?
    
}

// MARK: Decodable

extension UnsplashPosition: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
    }
    
}
