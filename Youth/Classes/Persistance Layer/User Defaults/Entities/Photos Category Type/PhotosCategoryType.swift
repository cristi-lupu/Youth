//
//  PhotosCategoryType.swift
//  Youth
//
//  Created by Lupu Cristian on 5/12/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public enum PhotosCategoryType: Int {
    case latest = 0
    case popular = 1
    case oldest = 2
}

extension PhotosCategoryType: CustomStringConvertible {

    public var description: String {
        switch self {
        case .latest: return "Latest"
        case .popular: return "Popular"
        case .oldest: return "Oldest"
        }
    }

    public static var allInOrder: [PhotosCategoryType] {
        return [.latest, .popular, .oldest]
    }

}
