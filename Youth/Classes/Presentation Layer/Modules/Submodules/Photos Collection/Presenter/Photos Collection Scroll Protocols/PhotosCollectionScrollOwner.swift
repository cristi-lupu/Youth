//
//  PhotosCollectionScrollOwner.swift
//  Youth
//
//  Created by Cristian Lupu on 5/31/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to notify receiver with scroll actions
protocol PhotosCollectionScrollOwner: class {

    /// Scroll Actions Receiver
    var photosCollectionScrollingUpdateReceiver: PhotosCollectionScrollingUpdateReceiver? { get set }

}
