//
//  PhotosCollectionScrollingUpdateReceiver.swift
//  Youth
//
//  Created by Lupu Cristian on 5/31/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to handle scroll actions
public protocol PhotosCollectionScrollingUpdateReceiver: class {

    //// Scroll did reach the end of the content
    func didScrollPhotosCollectionAtTheEndOfTheContent()

}
