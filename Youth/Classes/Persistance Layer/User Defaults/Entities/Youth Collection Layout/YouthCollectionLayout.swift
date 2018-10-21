//
//  YouthCollectionLayout.swift
//  Youth
//
//  Created by Cristian Lupu on 5/10/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

enum YouthCollectionLayout: Int {
    case grid
    case list

    var inversed: YouthCollectionLayout {
        switch self {
        case .grid: return .list
        case .list: return .grid
        }
    }
}
