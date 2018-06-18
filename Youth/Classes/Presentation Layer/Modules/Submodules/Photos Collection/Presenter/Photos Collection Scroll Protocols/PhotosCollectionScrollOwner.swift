//
//  PhotosCollectionScrollOwner.swift
//  Youth
//
//  Created by Lupu Cristian on 5/31/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to notify receiver with scroll actions
public protocol PhotosCollectionScrollOwner: class {

    /// Scroll Actions Receiver
    var photosCollectionScrollingUpdateReceiver: PhotosCollectionScrollingUpdateReceiver? { get set }

}
