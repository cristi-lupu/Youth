//
//  PhotosCollectionInteractor.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Alamofire
import RxSwift

final class PhotosCollectionInteractor {
    deinit {
        networkReachability?.stopListening()
        photoDownloader?.removeObserver(self)
    }

    // MARK: Output

    weak var output: PhotosCollectionInteractorOutput?

    // MARK: Network Reachability

    private let networkReachability: NetworkReachabilityManager?

    // MARK: Unsplash

    private let unsplash: UnsplashType

    // MARK: Photo Downloader

    private weak var photoDownloader: YouthPhotoDownloader?

    // MARK: Photo Saver

    private let photoSaver: YouthPhotoSaver

    private let disposeBag = DisposeBag()

    init(networkReachability: NetworkReachabilityManager?,
         unsplash: UnsplashType,
         photoDownloader: YouthPhotoDownloader,
         photoSaver: YouthPhotoSaver) {
        self.networkReachability = networkReachability
        self.unsplash = unsplash
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
    func obtainPhotos(atPage page: Int, perPage: Int, orderBy: Unsplash.PhotosOrderBy) {
        unsplash.photos(with: .init(page: page, perPage: perPage, orderBy: orderBy))
            .onSuccess { [weak self] in self?.output?.didObtain(photos: $0.model, atPage: page, withError: nil) }
            .unsplashOnFailure { [weak self] in self?.output?.didObtain(photos: [], atPage: page, withError: $0) }
            .run().disposed(by: disposeBag)
    }

    func obtainUserPhotos(username: String, atPage page: Int, perPage: Int, orderBy: Unsplash.PhotosOrderBy) {
        unsplash.userPhotos(for: username, pagination: .init(page: page, perPage: perPage, orderBy: orderBy))
            .onSuccess { [weak self] in self?.output?.didObtain(photos: $0.model, atPage: page, withError: nil) }
            .unsplashOnFailure { [weak self] in self?.output?.didObtain(photos: [], atPage: page, withError: $0) }
            .run().disposed(by: disposeBag)
    }

    func obtainPhotosOnSearch(query: String, atPage page: Int, perPage: Int) {
        unsplash.search(by: query, pagination: .init(page: page, perPage: perPage))
            .onSuccess {
                [weak self] in self?.output?.didObtain(photos: $0.model.results, atPage: page, withError: nil)
            }
            .unsplashOnFailure { [weak self] in self?.output?.didObtain(photos: [], atPage: page, withError: $0) }
            .run().disposed(by: disposeBag)
    }

    func download(photo: Unsplash.Photo) {
        photoDownloader?.download(photo: photo)
    }

    func cancelDownloadingPhoto(withID id: String) {
        photoDownloader?.cancelDownloadingPhoto(withID: id)
    }

    func isDownloadingPhoto(withID id: String) -> Bool {
        return photoDownloader?.isDownloadingPhoto(withID: id) ?? false
    }

    func save(image: UIImage, completion: @escaping YouthPhotoSaver.SaveCompletion) {
        photoSaver.save(image: image, completion: completion)
    }
}

extension PhotosCollectionInteractor: YouthPhotoDownloadObserver {
    func didUpdateProgress(photoID: String, progress: Double) {
        output?.didUpdateProgress(photoID: photoID, progress: progress)
    }

    func didDownload(photoID: String, image: UIImage?, withError error: Error?) {
        output?.didDownload(photoID: photoID, image: image, withError: error)
    }
}

extension PhotosCollectionInteractor {
    private func initialize(reachability: NetworkReachabilityManager) {
        reachability.listener = { reachabilityStatus in
            print(reachabilityStatus)
        }

        if !reachability.startListening() {
            print("Reachability listening was started with fail. 😪😪😪 sooo sad...")
        }
    }
}
