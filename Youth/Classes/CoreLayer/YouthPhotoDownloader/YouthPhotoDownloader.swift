//
//  YouthPhotoDownloader.swift
//  Youth
//
//  Created by Cristian Lupu on 6/16/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

// swiftlint:disable all

import Alamofire
import AlamofireImage

/// YouthPhotoDownloadObserver. The protocol describes the object which receive download actions
protocol YouthPhotoDownloadObserver: class {
    /**
     Receive update progress action
     
     - parameter photoID: ID of downloading photo
     - parameter progress: Progress
     */
    func didUpdateProgress(photoID: String, progress: Double)

    /**
     Receive finished download action
     
     - parameter photoID: ID of downloaded photo.
     - parameter image: `Optional` image. If error not occured image will be, otherwise `nil`.
     - parameter error: `Optional` occured error.
     */
    func didDownload(photoID: String, image: UIImage?, withError error: Error?)
}

final class YouthPhotoDownloader {

    /// YouthPhotoDownloader Error
    enum Error: Swift.Error {
        /// No Internet Connection
        case noInternetConnection

        /// Not found download location
        case notFoundDownloadLocation

        /// Could Not obtain download URL
        case couldNotObtainDowloadURL

        /// Cancelled
        case cancelled
    }

    // MARK: Private nested structs

    private struct WeakYouthPhotoDownloaderObserver {
        weak var observer: YouthPhotoDownloadObserver?
    }

    private struct DownloadingRequest {
        let requestReceipt: RequestReceipt
        var progress: Double = 0
    }

    // MARK: Private properties

    private let downloader: ImageDownloader
    private var currentDownloadingRequests: [DownloadingRequest] = []
    private var weakObservers: [WeakYouthPhotoDownloaderObserver] = []

    // MARK: Initializer

    private init() {
        downloader = ImageDownloader(maximumActiveDownloads: 2)
    }

    // MARK: Public properties

    /// YouthPhotoDownloader as singleton object
    static let `default` = YouthPhotoDownloader()

    /**
     Add download observer
     
     - parameter observer: Observer of type YouthPhotoDownloadObserver
     */
    func addObserver(_ observer: YouthPhotoDownloadObserver) {
        weakObservers = weakObservers.filter {
            $0.observer != nil && $0.observer !== observer
        }

        weakObservers.append(WeakYouthPhotoDownloaderObserver(observer: observer))
    }

    /**
     Remove download observer
     
     - parameter observer: Observer of type YouthPhotoDownloadObserver
     */
    func removeObserver(_ observer: YouthPhotoDownloadObserver) {
        weakObservers = weakObservers.filter {
            $0.observer != nil && $0.observer !== observer
        }
    }

    /**
     Check if photo is downloading
     
     - parameter id: Photo ID
     
     - returns: true if photo is downloading, otherwise false
     */
    func isDownloadingPhoto(withID id: String) -> Bool {
        return currentDownloadingRequests.contains { $0.requestReceipt.receiptID == id }
    }

    /**
     Progress for downloading photo
     
     - parameter id: Photo ID
     
     - returns: Progress if photo is downloading, otherwise `nil`.
     */
    func progressForPhoto(withID id: String) -> Double? {
        guard let index = currentDownloadingRequests.firstIndex(where: { $0.requestReceipt.receiptID == id }) else {
            return nil
        }
        return currentDownloadingRequests[index].progress
    }

    /**
     Cancel downloading photo
     
     - parameter id: Photo ID
     */
    func cancelDownloadingPhoto(withID id: String) {
        guard let index = currentDownloadingRequests.firstIndex(where: { $0.requestReceipt.receiptID == id }) else {
            return
        }
        downloader.cancelRequest(with: currentDownloadingRequests[index].requestReceipt)
    }

    /**
     Download photo
     
     - parameter photo: Photo to download
     */
    func download(photo: Unsplash.Photo) {
        guard let id = photo.id else { return }
        guard let downloadLocation = photo.links?.downloadLocation else {
            weakObservers.forEach {
                $0.observer?.didDownload(photoID: id,
                                         image: nil,
                                         withError: Error.notFoundDownloadLocation)
            }
            return
        }

        sendDownloadLocationRequest(downloadLocation: downloadLocation) { [weak self] success, downloadURL in
            guard let strongSelf = self else {
                return
            }

            if success {
                let receipt = strongSelf.downloadImage(
                    id: id,
                    url: downloadURL!,
                    onProgress: { [weak self] progress in
                        guard let strongSelf = self else {
                            return
                        }

                        guard let index = strongSelf.currentDownloadingRequests.firstIndex(where: {
                            $0.requestReceipt.receiptID == id
                        }) else {
                            return
                        }

                        strongSelf.currentDownloadingRequests[index].progress = progress

                        strongSelf.weakObservers.forEach {
                            $0.observer?.didUpdateProgress(photoID: id,
                                                           progress: progress)
                        }
                    },
                    completion: { [weak self, id] dataResponse in
                        guard let strongSelf = self else {
                            return
                        }

                        strongSelf.safelyRemoveRequest(withID: id)

                        if let err = dataResponse.error {
                            if let error = err as? URLError {
                                if error.code == .notConnectedToInternet {
                                    strongSelf.weakObservers.forEach {
                                        $0.observer?.didDownload(photoID: id,
                                                                 image: dataResponse.value,
                                                                 withError: Error.noInternetConnection)
                                    }
                                    return
                                } else if error.code == .cancelled {
                                    strongSelf.weakObservers.forEach {
                                        $0.observer?.didDownload(photoID: id,
                                                                 image: dataResponse.value,
                                                                 withError: Error.cancelled)
                                    }
                                    return
                                }
                            }

                            strongSelf.weakObservers.forEach {
                                $0.observer?.didDownload(photoID: id,
                                                         image: dataResponse.value,
                                                         withError: err)
                            }
                            return
                        }
                        strongSelf.weakObservers.forEach {
                            $0.observer?.didDownload(photoID: id,
                                                     image: dataResponse.value!,
                                                     withError: nil)
                        }
                    })

                if let receipt = receipt {
                    strongSelf.currentDownloadingRequests.append(
                        DownloadingRequest(requestReceipt: receipt, progress: 0.0)
                    )
                }
            } else {
                strongSelf.weakObservers.forEach {
                    $0.observer?.didDownload(photoID: id,
                                             image: nil,
                                             withError: Error.couldNotObtainDowloadURL)
                }
            }
        }
    }

    // MARK: Private methods

    typealias DownloadOnProgress = (Double) -> Void

    private func downloadImage(
        id: String, url: URL,
        onProgress: @escaping DownloadOnProgress,
        completion: @escaping ImageDownloader.CompletionHandler
        ) -> RequestReceipt? {
        let request = URLRequest(url: url)

        return downloader.download(
            request,
            receiptID: id,
            progress: { progress in
                onProgress(Double(progress.completedUnitCount) / Double(progress.totalUnitCount))
            },
            progressQueue: .main,
            completion: completion)
    }

    private typealias DownloadLocationRequestCompletion = (_ success: Bool, _ downloadURL: URL?) -> Void

    private func sendDownloadLocationRequest(downloadLocation: URL, completion: @escaping DownloadLocationRequestCompletion) {
        var downloadRequest = URLRequest(url: downloadLocation)

        var headers: HTTPHeaders = [:]

        headers["Accept-Version"] = "v1"
        headers["Authorization"] = "Client-ID \(Unsplash.Constants.clientID)"

        for (key, value) in headers {
            downloadRequest.setValue(value, forHTTPHeaderField: key)
        }

        Alamofire.request(downloadRequest).responseData { dataResponse in
            guard dataResponse.error == nil,
                let data = dataResponse.value,
                let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                let downloadURL = dict["url"] as? URL else {
                    completion(false, nil)
                    return
            }
            completion(true, downloadURL)
        }
    }

    private func safelyRemoveRequest(withID id: String) {
        guard let index = currentDownloadingRequests.firstIndex(where: { $0.requestReceipt.receiptID == id }) else {
            return
        }
        currentDownloadingRequests.remove(at: index)
    }
}
