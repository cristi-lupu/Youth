//
//  PhotoProvider.swift
//  Youth
//
//  Created by Cristian Lupu on 6/15/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Responsible to obtain photo
final class PhotoProvider {
    typealias PhotoProviderNetworkClient = PhotoNetworkRequester

    deinit {
        currentRequest?.cancelRequest()
    }

    /// Provider Error
    enum Error: Swift.Error {
        /// No internet connection
        case noInternetConnection

        /// Internal
        case `internal`
    }

    /// Photo Result
    enum PhotoResult<ProviderError> where ProviderError: Swift.Error {

        /// Success
        case success(payload: UnsplashPhoto)

        /// Failure
        case failure(ProviderError)
    }

    private let networkClient: PhotoProviderNetworkClient

    private var currentRequest: NetworkRequestCancelable?

    init(networkClient: PhotoProviderNetworkClient) {
        self.networkClient = networkClient
    }
}

extension PhotoProvider {
    func cancelNetworkRequest() {
        currentRequest?.cancelRequest()
    }
}

extension PhotoProvider {
    typealias PhotoProviderCompletion = (PhotoResult<Error>) -> Void

    func photo(id: String, usage: ProviderUsage, completion: @escaping PhotoProviderCompletion) {
        switch usage {
        case .network:
            currentRequest = networkClient.photo(id: id) { result in
                switch result {
                case let .success(payload, _):
                    completion(.success(payload: payload))
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
