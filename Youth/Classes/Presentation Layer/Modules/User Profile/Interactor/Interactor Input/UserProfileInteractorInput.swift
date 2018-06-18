//
//  UserProfileInteractorInput.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public protocol UserProfileInteractorInput: class {

    func openInstagramUserProfile(username: String)

    func openTwitterUserProfile(username: String)

}
