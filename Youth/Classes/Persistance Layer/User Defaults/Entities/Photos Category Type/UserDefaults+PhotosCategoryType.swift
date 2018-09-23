//
//  UserDefaults+PhotosCategoryType.swift
//  Youth
//
//  Created by Lupu Cristian on 5/20/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private var photosCategoryTypeKey: String {
        return "CurrentPhotosCategoryType"
    }
    
    var photosCategoryType: PhotosCategoryType {
        get {
            return PhotosCategoryType(rawValue: integer(forKey: photosCategoryTypeKey)) ?? .latest
        }
        set {
            set(newValue.rawValue, forKey: photosCategoryTypeKey)
        }
    }
    
}
