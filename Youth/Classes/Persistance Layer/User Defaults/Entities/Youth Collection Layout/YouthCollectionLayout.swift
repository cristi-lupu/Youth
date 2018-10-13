//
//  YouthCollectionLayout.swift
//  Youth
//
//  Created by Cristian Lupu on 5/10/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

enum YouthCollectionLayout: Int {
    case grid = 0
    case list = 1
    
    var inversed: YouthCollectionLayout {
        switch self {
        case .grid:
            return .list
        case .list:
            return .grid
        }
    }
}
