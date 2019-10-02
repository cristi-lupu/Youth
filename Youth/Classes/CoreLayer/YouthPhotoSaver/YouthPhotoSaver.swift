//
//  YouthPhotoSaver.swift
//  Youth
//
//  Created by Cristian Lupu on 6/17/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Photos

/// Responsible to create album with name `Youth` and save image into album.
final class YouthPhotoSaver {
    /// Saver Error
    enum Error: Swift.Error {

        /// Ocurred some problems in creating album
        case couldNotCreateAlbum
    }

    // MARK: Private properties

    private var albumName: String {
        return "Youth"
    }

    // MARK: Public methods

    typealias SaveCompletion = (_ success: Bool, _ error: Swift.Error?) -> Void

    /**
     Save image
     
     - parameter image: Image to save
     - parameter completion: Completion Handler
     */
    func save(image: UIImage, completion: @escaping SaveCompletion) {
        var assetCollection: PHAssetCollection?
        var hasAlbum = false

        // swiftlint:disable:next identifier_name
        if let _assetCollection = fetchAssetCollectionForAlbum() {
            assetCollection = _assetCollection
            hasAlbum = true
        } else {
            createAlbum { [weak self] success, error in
                guard let strongSelf = self else {
                    return
                }

                if success {
                    let assetCollection = strongSelf.fetchAssetCollectionForAlbum()
                    strongSelf._save(image: image, assetCollection: assetCollection, completion: completion)
                } else {
                    DispatchQueue.main.async {
                        completion(false, error)
                    }
                }
            }
        }

        if hasAlbum {
            _save(image: image, assetCollection: assetCollection, completion: completion)
        }
    }

    // MARK: Private methods

    private func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        return collection.firstObject
    }

    private func createAlbum(completion: @escaping ((_ success: Bool, _ error: Swift.Error?) -> Void)) {
        PHPhotoLibrary.shared().performChanges({ [weak self] in
            guard let strongSelf = self else {
                return
            }

            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: strongSelf.albumName)
            }, completionHandler: completion)
    }

    private func _save(image: UIImage, assetCollection: PHAssetCollection?, completion: @escaping SaveCompletion) {
        guard let assetCollection = assetCollection else {
            DispatchQueue.main.async {
                completion(false, Error.couldNotCreateAlbum)
            }
            return
        }

        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)

            guard let assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset,
                let albumChangeRequest = PHAssetCollectionChangeRequest(for: assetCollection) else {
                    return
            }

            let enumeration: NSArray = [assetPlaceHolder]

            if assetCollection.estimatedAssetCount == 0 {
                albumChangeRequest.addAssets(enumeration)
            } else {
                albumChangeRequest.insertAssets(enumeration, at: [0])
            }
        }, completionHandler: { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        })
    }
}
