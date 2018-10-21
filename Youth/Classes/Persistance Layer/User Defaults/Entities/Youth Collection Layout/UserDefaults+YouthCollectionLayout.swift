//
//  UserDefaults+YouthCollectionLayout.swift
//  Youth
//
//  Created by Cristian Lupu on 5/20/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

extension UserDefaults {

    private var photosCollectionLayoutKey: String {
        return "PhotosCollectionLayoutKey"
    }

    var photosCollectionLayout: YouthCollectionLayout {
        get {
            return YouthCollectionLayout(rawValue: integer(forKey: photosCollectionLayoutKey)) ?? .list
        }
        set {
            set(newValue.rawValue, forKey: photosCollectionLayoutKey)
        }
    }

}
