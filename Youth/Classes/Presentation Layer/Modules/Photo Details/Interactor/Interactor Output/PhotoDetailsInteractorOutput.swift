//
//  PhotoDetailsInteractorOutput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotoDetailsInteractorOutput: class {
    func didObtain(photo: Unsplash.Photo?, withError error: Error?)
}
