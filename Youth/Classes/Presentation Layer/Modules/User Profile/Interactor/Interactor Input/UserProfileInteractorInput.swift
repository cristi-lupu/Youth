//
//  UserProfileInteractorInput.swift
//  Youth
//
//  Created by Cristian Lupu on 19/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol UserProfileInteractorInput: class {
    
    func openInstagramUserProfile(username: String)
    
    func openTwitterUserProfile(username: String)
    
}
