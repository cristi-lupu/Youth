//
//  UserProfileModuleInput.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public protocol UserProfileModuleInput: class {

    func configure(withUser user: UnsplashUser)

}
