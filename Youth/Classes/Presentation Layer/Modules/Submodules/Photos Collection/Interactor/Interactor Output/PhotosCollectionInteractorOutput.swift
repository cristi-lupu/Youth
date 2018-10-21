//
//  PhotosCollectionInteractorOutput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotosCollectionInteractorOutput: class {

    func didObtain(photos: [UnsplashPhoto], atPage page: Int, withError error: PhotosCollectionProvider.Error?)

    func didUpdateProgress(photoID: String, progress: Double)

    func didDownload(photoID: String, image: UIImage?, withError error: Error?)

}
