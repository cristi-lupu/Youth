//
//  PhotosCollectionInteractorInput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

protocol PhotosCollectionInteractorInput: class {
    
    func obtainPhotos(atPage page: Int, perPage: Int, orderBy: UnsplashPhotosOrderBy)
    
    func obtainUserPhotos(username: String, atPage page: Int, perPage: Int, orderBy: UnsplashPhotosOrderBy)
    
    func obtainPhotosOnSearch(query: String, atPage page: Int, perPage: Int)
    
    func download(photo: UnsplashPhoto)
    
    func cancelDownloadingPhoto(withID id: String)
    
    func isDownloadingPhoto(withID id: String) -> Bool
    
    func save(image: UIImage, completion: @escaping YouthPhotoSaver.SaveCompletion)
    
}
