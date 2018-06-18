//
//  PhotoDetailsInteractorOutput.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public protocol PhotoDetailsInteractorOutput: class {

    func didObtain(photo: UnsplashPhoto?, withError error: PhotoProvider.Error?)

}
