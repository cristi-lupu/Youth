//
//  PhotosCategoryType.swift
//  Youth
//
//  Created by Cristian Lupu on 5/12/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

enum PhotosCategoryType: Int {
    case latest
    case popular
    case oldest
}

extension PhotosCategoryType: CustomStringConvertible {
    var description: String {
        switch self {
        case .latest: return "Latest"
        case .popular: return "Popular"
        case .oldest: return "Oldest"
        }
    }

    static var allInOrder: [PhotosCategoryType] {
        return [.latest, .popular, .oldest]
    }
}
