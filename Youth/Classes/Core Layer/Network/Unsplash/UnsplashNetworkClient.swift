//
//  UnsplashNetworkClient.swift
//  Youth
//
//  Created by Lupu Cristian on 4/21/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Alamofire

/**
 Client for performing network requests with Unsplash API
 */
public final class UnsplashNetworkClient {

    private let authorization: UnsplashAuthorization

    private let stubbing: NetworkStubbing

    /**
     Initialization with authorization

     - parameter authorization: Unsplash Authorization.
     - parameter stubbing: Stubbing.

     - note: Parameter authorization is default.
     - note: Parameter stubbing is default. Use for testing only.
     */
    public init(with authorization: UnsplashAuthorization = .default,
                stubbing: NetworkStubbing = .never) {
        self.authorization = authorization
        self.stubbing = stubbing
    }

    private func request(for api: UnsplashAPI) -> DataRequest {
        let task = api.task
        let request = Alamofire.request(task.endpoint,
                                        method: task.method,
                                        parameters: task.parameters,
                                        encoding: task.encoding,
                                        headers: task.headers)
        return request
    }

    private func stubbing<Model>(for case: NetworkStubbing,
                                 data _data: Data?,
                                 modelType: Model.Type,
                                 onSuccess: @escaping ((Model) -> ()),
                                 onFail: @escaping ((NetworkStubbing.StubbingError) -> ())) where Model: Decodable {
        func execute() {
            guard let data = _data else {
                onFail(.noData)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(modelType, from: data)
                onSuccess(decoded)
            } catch {
                onFail(.decodingError)
            }
        }

        switch `case` {
        case .immediately:
            execute()
        case .never:
            onFail(.stubbingIsNever)
        }
    }

}

extension UnsplashNetworkClient: PhotosNetworkRequester {

    @discardableResult
    public func photos(page: Int,
                       perPage: Int,
                       orderBy: UnsplashPhotosOrderBy,
                       completion: @escaping PhotosResponse) -> NetworkRequestCancelable {
        let api = UnsplashAPI.photos(page: page,
                                     perPage: perPage,
                                     orderBy: orderBy,
                                     authorization: authorization)

        let request = self.request(for: api)

        switch self.stubbing {
        case .never:
            request.responseData(queue: DispatchQueue.global(qos: .utility)) { (dataResponse) in
                if let err = dataResponse.error {
                    if let error = err as? URLError {
                        if error.code == .notConnectedToInternet {
                            completion(.failure(.noInternetConnection))
                            return
                        } else if error.code == .cancelled {
                            completion(.failure(.cancelled))
                            return
                        }
                    }

                    completion(.failure(.another(error: err)))
                    return
                }

                guard let data = dataResponse.value else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                    let rateLimit = UnsplashRateLimit.rateLimit(from: dataResponse.response)
                    completion(.success(payload: decoded, rateLimit: rateLimit))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        default:
            self.stubbing(for: self.stubbing,
                          data: api.stubData,
                          modelType: [UnsplashPhoto].self,
                          onSuccess: { (model) in
                            completion(UnsplashResult.success(payload: model, rateLimit: nil))
            }) { (error) in
                completion(UnsplashResult.failure(.noData))
            }
        }

        return request
    }

}

extension UnsplashNetworkClient: UserPublicProfileNetworkRequester {

    @discardableResult
    public func userPublicProfile(username: String,
                                  completion: @escaping UserPublicProfileResponse) -> NetworkRequestCancelable {
        let api = UnsplashAPI.userPublicProfile(username: username,
                                                authorization: authorization)

        let request = self.request(for: api)

        switch self.stubbing {
        case .never:
            request.responseData(queue: DispatchQueue.global(qos: .utility)) { (dataResponse) in
                if let err = dataResponse.error {
                    if let error = err as? URLError {
                        if error.code == .notConnectedToInternet {
                            completion(.failure(.noInternetConnection))
                            return
                        } else if error.code == .cancelled {
                            completion(.failure(.cancelled))
                            return
                        }
                    }

                    completion(.failure(.another(error: err)))
                    return
                }

                guard let data = dataResponse.value else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(UnsplashUser.self, from: data)
                    let rateLimit = UnsplashRateLimit.rateLimit(from: dataResponse.response)
                    completion(.success(payload: decoded, rateLimit: rateLimit))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        default:
            self.stubbing(for: self.stubbing,
                          data: api.stubData,
                          modelType: UnsplashUser.self,
                          onSuccess: { (model) in
                            completion(UnsplashResult.success(payload: model, rateLimit: nil))
            }) { (error) in
                completion(UnsplashResult.failure(.noData))
            }
        }

        return request
    }

}

extension UnsplashNetworkClient: UserPhotosNetworkRequester {

    @discardableResult
    public func userPhotos(username: String,
                           page: Int,
                           perPage: Int,
                           orderBy: UnsplashPhotosOrderBy,
                           includeStats: Bool,
                           completion: @escaping PhotosResponse) -> NetworkRequestCancelable {
        let api = UnsplashAPI.userPhotos(username: username,
                                         page: page,
                                         perPage: perPage,
                                         orderBy: orderBy,
                                         includeStats: includeStats,
                                         authorization: authorization)

        let request = self.request(for: api)

        switch self.stubbing {
        case .never:
            request.responseData(queue: DispatchQueue.global(qos: .utility)) { (dataResponse) in
                if let err = dataResponse.error {
                    if let error = err as? URLError {
                        if error.code == .notConnectedToInternet {
                            completion(.failure(.noInternetConnection))
                            return
                        } else if error.code == .cancelled {
                            completion(.failure(.cancelled))
                            return
                        }
                    }

                    completion(.failure(.another(error: err)))
                    return
                }

                guard let data = dataResponse.value else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                    let rateLimit = UnsplashRateLimit.rateLimit(from: dataResponse.response)
                    completion(.success(payload: decoded, rateLimit: rateLimit))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        default:
            self.stubbing(for: self.stubbing,
                          data: api.stubData,
                          modelType: [UnsplashPhoto].self,
                          onSuccess: { (model) in
                            completion(UnsplashResult.success(payload: model, rateLimit: nil))
            }) { (error) in
                completion(UnsplashResult.failure(.noData))
            }
        }

        return request
    }

}

extension UnsplashNetworkClient: UserLikedPhotosNetworkRequester {

    @discardableResult
    public func userLikedPhotos(username: String,
                                page: Int,
                                perPage: Int,
                                orderBy: UnsplashPhotosOrderBy,
                                completion: @escaping PhotosResponse) -> NetworkRequestCancelable {
        let api = UnsplashAPI.userLikedPhotos(username: username,
                                         page: page,
                                         perPage: perPage,
                                         orderBy: orderBy,
                                         authorization: authorization)

        let request = self.request(for: api)

        switch self.stubbing {
        case .never:
            request.responseData(queue: DispatchQueue.global(qos: .utility)) { (dataResponse) in
                if let err = dataResponse.error {
                    if let error = err as? URLError {
                        if error.code == .notConnectedToInternet {
                            completion(.failure(.noInternetConnection))
                            return
                        } else if error.code == .cancelled {
                            completion(.failure(.cancelled))
                            return
                        }
                    }

                    completion(.failure(.another(error: err)))
                    return
                }

                guard let data = dataResponse.value else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                    let rateLimit = UnsplashRateLimit.rateLimit(from: dataResponse.response)
                    completion(.success(payload: decoded, rateLimit: rateLimit))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        default:
            self.stubbing(for: self.stubbing,
                          data: api.stubData,
                          modelType: [UnsplashPhoto].self,
                          onSuccess: { (model) in
                            completion(UnsplashResult.success(payload: model, rateLimit: nil))
            }) { (error) in
                completion(UnsplashResult.failure(.noData))
            }
        }

        return request
    }

}

extension UnsplashNetworkClient: SearchPhotosNetworkRequester {

    @discardableResult
    public func searchPhotos(query: String,
                             page: Int,
                             perPage: Int,
                             completion: @escaping SearchPhotosResponse) -> NetworkRequestCancelable {
        let api = UnsplashAPI.searchPhotos(query: query,
                                           page: page,
                                           perPage: perPage,
                                           authorization: authorization)

        let request = self.request(for: api)

        switch self.stubbing {
        case .never:
            request.responseData(queue: DispatchQueue.global(qos: .utility)) { (dataResponse) in
                if let err = dataResponse.error {
                    if let error = err as? URLError {
                        if error.code == .notConnectedToInternet {
                            completion(.failure(.noInternetConnection))
                            return
                        } else if error.code == .cancelled {
                            completion(.failure(.cancelled))
                            return
                        }
                    }

                    completion(.failure(.another(error: err)))
                    return
                }

                guard let data = dataResponse.value else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(UnsplashSearchResult<UnsplashPhoto>.self, from: data)
                    let rateLimit = UnsplashRateLimit.rateLimit(from: dataResponse.response)
                    completion(.success(payload: decoded, rateLimit: rateLimit))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        default:
            self.stubbing(for: self.stubbing,
                          data: api.stubData,
                          modelType: UnsplashSearchResult<UnsplashPhoto>.self,
                          onSuccess: { (model) in
                            completion(UnsplashResult.success(payload: model, rateLimit: nil))
            }) { (error) in
                completion(UnsplashResult.failure(.noData))
            }
        }

        return request
    }

}

extension UnsplashNetworkClient: PhotoNetworkRequester {

    public func photo(id: String, completion: @escaping PhotoResponse) -> NetworkRequestCancelable {
        let api = UnsplashAPI.photo(id: id,
                                    width: nil,
                                    height: nil,
                                    cropRect: nil,
                                    authorization: authorization)

        let request = self.request(for: api)

        switch self.stubbing {
        case .never:
            request.responseData(queue: DispatchQueue.global(qos: .utility)) { (dataResponse) in
                if let err = dataResponse.error {
                    if let error = err as? URLError {
                        if error.code == .notConnectedToInternet {
                            completion(.failure(.noInternetConnection))
                            return
                        } else if error.code == .cancelled {
                            completion(.failure(.cancelled))
                            return
                        }
                    }

                    completion(.failure(.another(error: err)))
                    return
                }

                guard let data = dataResponse.value else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(UnsplashPhoto.self, from: data)
                    let rateLimit = UnsplashRateLimit.rateLimit(from: dataResponse.response)
                    completion(.success(payload: decoded, rateLimit: rateLimit))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        default:
            self.stubbing(for: self.stubbing,
                          data: api.stubData,
                          modelType: UnsplashPhoto.self,
                          onSuccess: { (model) in
                            completion(UnsplashResult.success(payload: model, rateLimit: nil))
            }) { (error) in
                completion(UnsplashResult.failure(.noData))
            }
        }

        return request
    }

}
