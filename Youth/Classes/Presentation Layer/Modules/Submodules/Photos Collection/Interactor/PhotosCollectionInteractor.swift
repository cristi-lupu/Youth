//
//  PhotosCollectionInteractor.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Alamofire

public final class PhotosCollectionInteractor {

    deinit {
        networkReachability?.stopListening()
        photoDownloader?.removeObserver(self)
    }

    // MARK: Output

    public weak var output: PhotosCollectionInteractorOutput?

    // MARK: Network Reachability

    private let networkReachability: NetworkReachabilityManager?

    // MARK: Photos Provider

    private let photosProvider: PhotosCollectionProvider

    // MARK: Photo Downloader

    private weak var photoDownloader: YouthPhotoDownloader?

    // MARK: Photo Saver

    private let photoSaver: YouthPhotoSaver

    public init(networkReachability: NetworkReachabilityManager?,
                photosProvider: PhotosCollectionProvider,
                photoDownloader: YouthPhotoDownloader,
                photoSaver: YouthPhotoSaver) {
        self.networkReachability = networkReachability
        self.photosProvider = photosProvider
        self.photoDownloader = photoDownloader
        self.photoSaver = photoSaver

        if let reachability = self.networkReachability {
            initialize(reachability: reachability)
        }

        self.photoDownloader?.addObserver(self)
    }

}

// MARK: PhotosCollectionInteractorInput 

extension PhotosCollectionInteractor: PhotosCollectionInteractorInput {

    public func obtainPhotos(atPage page: Int, perPage: Int, orderBy: UnsplashPhotosOrderBy) {
        photosProvider.cancelNetworkRequest()

        photosProvider.photos(
            page: page,
            perPage: perPage,
            orderBy: orderBy,
            usage: .network,
            completion: { [weak self] (photosResult) in
                DispatchQueue.main.async {
                    guard let strongSelf = self else {
                        return
                    }

                    switch photosResult {
                    case .success(let payload):
                        strongSelf.output?.didObtain(photos: payload,
                                                     atPage: page,
                                                     withError: nil)
                    case let .failure(photosError):
                        strongSelf.output?.didObtain(photos: [],
                                                     atPage: page,
                                                     withError: photosError)
                    }
                }
        })
    }

    public func obtainUserPhotos(username: String, atPage page: Int, perPage: Int, orderBy: UnsplashPhotosOrderBy) {
        photosProvider.cancelNetworkRequest()

        photosProvider.userPhotos(
            username: username,
            page: page,
            perPage: perPage,
            orderBy: orderBy,
            usage: .network,
            completion: {  [weak self] (photosResult) in
                DispatchQueue.main.async {
                    guard let strongSelf = self else {
                        return
                    }

                    switch photosResult {
                    case .success(let payload):
                        strongSelf.output?.didObtain(photos: payload,
                                                     atPage: page,
                                                     withError: nil)
                    case let .failure(photosError):
                        strongSelf.output?.didObtain(photos: [],
                                                     atPage: page,
                                                     withError: photosError)
                    }
                }
        })
    }

    public func obtainPhotosOnSearch(query: String, atPage page: Int, perPage: Int) {
        photosProvider.cancelNetworkRequest()

        photosProvider.searchPhotos(
            query: query,
            page: page,
            perPage: perPage,
            usage: .network,
            completion: { [weak self] (photosResult) in
                DispatchQueue.main.async {
                    guard let strongSelf = self else {
                        return
                    }

                    switch photosResult {
                    case .success(let payload):
                        strongSelf.output?.didObtain(photos: payload,
                                                     atPage: page,
                                                     withError: nil)
                    case let .failure(photosError):
                        strongSelf.output?.didObtain(photos: [],
                                                     atPage: page,
                                                     withError: photosError)
                    }
                }
        })
    }

    public func download(photo: UnsplashPhoto) {
        photoDownloader?.download(photo: photo)
    }

    public func cancelDownloadingPhoto(withID id: String) {
        photoDownloader?.cancelDownloadingPhoto(withID: id)
    }

    public func isDownloadingPhoto(withID id: String) -> Bool {
        return photoDownloader?.isDownloadingPhoto(withID: id) ?? false
    }

    public func save(image: UIImage, completion: @escaping YouthPhotoSaver.SaveCompletion) {
        photoSaver.save(image: image, completion: completion)
    }
    
}

extension PhotosCollectionInteractor: YouthPhotoDownloadObserver {

    public func didUpdateProgress(photoID: String, progress: Double) {
        output?.didUpdateProgress(photoID: photoID, progress: progress)
    }

    public func didDownload(photoID: String, image: UIImage?, withError error: Error?) {
        output?.didDownload(photoID: photoID, image: image, withError: error)
    }

}

extension PhotosCollectionInteractor {

    private func initialize(reachability: NetworkReachabilityManager) {
        reachability.listener = { (reachabilityStatus) in
            print(reachabilityStatus)
        }

        if !reachability.startListening() {
            print("Reachability listening was started with fail. 😪😪😪 sooo sad...")
        }
    }

}
