//
//  PhotosCollectionScrollingUpdateReceiver.swift
//  Youth
//
//  Created by Cristian Lupu on 5/31/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to handle scroll actions
protocol PhotosCollectionScrollingUpdateReceiver: class {

    //// Scroll did reach the end of the content
    func didScrollPhotosCollectionAtTheEndOfTheContent()

}
