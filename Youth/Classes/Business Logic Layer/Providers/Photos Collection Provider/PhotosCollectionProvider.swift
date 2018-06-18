//
//  PhotosCollectionProvider.swift
//  Youth
//
//  Created by Lupu Cristian on 5/11/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation
import Alamofire

/// Responsible to obtain photos
public final class PhotosCollectionProvider {

    public typealias PhotosProviderNetworkClient = PhotosNetworkRequester & UserPhotosNetworkRequester & UserLikedPhotosNetworkRequester & SearchPhotosNetworkRequester

    deinit {
        currentRequest?.cancelRequest()
    }

    public enum Error: Swift.Error {
        case noInternetConnection
        case noMorePhotos
        case `internal`
    }

    public enum PhotosResult<Model, ProviderError> where ProviderError: Swift.Error {
        case success(payload: Model)
        case failure(ProviderError)
    }

    private let networkClient: PhotosProviderNetworkClient

    private var currentRequest: NetworkRequestCancelable?

    public init(networkClient: PhotosProviderNetworkClient) {
        self.networkClient = networkClient
    }

}

extension PhotosCollectionProvider {

    public func cancelNetworkRequest() {
        currentRequest?.cancelRequest()
    }

}

extension PhotosCollectionProvider {

    public typealias PhotosProviderCompletion = (PhotosResult<[UnsplashPhoto], Error>) -> ()

    public func photos(page: Int,
                       perPage: Int,
                       orderBy: UnsplashPhotosOrderBy,
                       usage: ProviderUsage,
                       completion: @escaping PhotosProviderCompletion) {
        switch usage {
        case .network:
            currentRequest = networkClient.photos(
                page: page,
                perPage: perPage,
                orderBy: orderBy) { (result) in
                    switch result {
                    case let .success(payload, _):
                        if payload.isEmpty {
                            completion(.failure(.noMorePhotos))
                        } else {
                            completion(.success(payload: payload))
                        }
                        break
                    case let .failure(error):
                        switch error {
                        case .noInternetConnection:
                            completion(.failure(.noInternetConnection))
                        case .decodingError, .noData, .another:
                            completion(.failure(.`internal`))
                        case .cancelled:
                            break
                        }
                    }
            }
        case .persistance:
            break
        }
    }

}

extension PhotosCollectionProvider {

    public func userPhotos(username: String,
                           page: Int,
                           perPage: Int,
                           orderBy: UnsplashPhotosOrderBy,
                           usage: ProviderUsage,
                           completion: @escaping PhotosProviderCompletion) {
        switch usage {
        case .network:
            currentRequest = networkClient.userPhotos(
                username: username,
                page: page,
                perPage: perPage,
                orderBy: orderBy,
                includeStats: true) { (result) in
                    switch result {
                    case let .success(payload, _):
                        if payload.isEmpty {
                            completion(.failure(.noMorePhotos))
                        } else {
                            completion(.success(payload: payload))
                        }
                        break
                    case let .failure(error):
                        switch error {
                        case .noInternetConnection:
                            completion(.failure(.noInternetConnection))
                        case .decodingError, .noData, .another:
                            completion(.failure(.`internal`))
                        case .cancelled:
                            break
                        }
                    }
            }
        case .persistance:
            break
        }
    }

}

extension PhotosCollectionProvider {

    public func userLikedPhotos(username: String,
                                page: Int,
                                perPage: Int,
                                orderBy: UnsplashPhotosOrderBy,
                                usage: ProviderUsage,
                                completion: @escaping PhotosProviderCompletion) {
        switch usage {
        case .network:
            currentRequest = networkClient.userLikedPhotos(
                username: username,
                page: page,
                perPage: perPage,
                orderBy: orderBy) { (result) in
                    switch result {
                    case let .success(payload, _):
                        if payload.isEmpty {
                            completion(.failure(.noMorePhotos))
                        } else {
                            completion(.success(payload: payload))
                        }
                        break
                    case let .failure(error):
                        switch error {
                        case .noInternetConnection:
                            completion(.failure(.noInternetConnection))
                        case .decodingError, .noData, .another:
                            completion(.failure(.`internal`))
                        case .cancelled:
                            break
                        }
                    }
            }
        case .persistance:
            break
        }
    }

}

extension PhotosCollectionProvider {

    public func searchPhotos(query: String,
                             page: Int,
                             perPage: Int,
                             usage: ProviderUsage,
                             completion: @escaping PhotosProviderCompletion) {
        guard !query.isEmpty else {
            completion(.success(payload: []))
            return
        }

        switch usage {
        case .network:
            currentRequest = networkClient.searchPhotos(
                query: query,
                page: page,
                perPage: perPage,
                completion: { (result) in
                    switch result {
                    case let .success(payload, _):
                        if payload.results.isEmpty {
                            completion(.failure(.noMorePhotos))
                        } else {
                            completion(.success(payload: payload.results))
                        }
                        break
                    case let .failure(error):
                        switch error {
                        case .noInternetConnection:
                            completion(.failure(.noInternetConnection))
                        case .decodingError, .noData, .another:
                            completion(.failure(.`internal`))
                        case .cancelled:
                            break
                        }
                    }
            })
        case .persistance:
            break
        }
    }

}
