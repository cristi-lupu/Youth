//
//  UserDefaults+YouthCollectionLayout.swift
//  Youth
//
//  Created by Lupu Cristian on 5/20/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
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
