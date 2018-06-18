//
//  PhotoProvider.swift
//  Youth
//
//  Created by Lupu Cristian on 6/15/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to obtain photo
public final class PhotoProvider {

    public typealias PhotoProviderNetworkClient = PhotoNetworkRequester

    deinit {
        currentRequest?.cancelRequest()
    }

    /// Provider Error
    public enum Error: Swift.Error {
        /// No internet connection
        case noInternetConnection

        /// Internal
        case `internal`
    }

    /// Photo Result
    public enum PhotoResult<ProviderError> where ProviderError: Swift.Error {

        /// Success
        case success(payload: UnsplashPhoto)

        /// Failure
        case failure(ProviderError)
    }

    private let networkClient: PhotoProviderNetworkClient

    private var currentRequest: NetworkRequestCancelable?

    public init(networkClient: PhotoProviderNetworkClient) {
        self.networkClient = networkClient
    }

}

extension PhotoProvider {

    public func cancelNetworkRequest() {
        currentRequest?.cancelRequest()
    }

}

extension PhotoProvider {

    public typealias PhotoProviderCompletion = (PhotoResult<Error>) -> ()

    public func photo(id: String, usage: ProviderUsage, completion: @escaping PhotoProviderCompletion) {
        switch usage {
        case .network:
            currentRequest = networkClient.photo(id: id) { (result) in
                switch result {
                case let .success(payload, _):
                    completion(.success(payload: payload))
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
