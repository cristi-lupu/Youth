//
//  Unplash.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya
import RxSwift

final class Unsplash: UnsplashType {
    private let photosProvider: MoyaProvider<PhotosRequestComposer>
    private let usersProvider: MoyaProvider<UsersRequestComposer>
    private let searchProvider: MoyaProvider<SearchRequestComposer>
    private let authorizationPlugin: AuthorizationPlugin

    init(authorization: Authorization = .default) {
        authorizationPlugin = AuthorizationPlugin(authorization: authorization)
        photosProvider = MoyaProvider(plugins: [authorizationPlugin])
        usersProvider = MoyaProvider(plugins: [authorizationPlugin])
        searchProvider = MoyaProvider(plugins: [authorizationPlugin])
    }
}

// MARK: Photos

extension Unsplash {
    func photos(with pagination: Unsplash.PhotosPagination)
        -> Observable<Unsplash.Response<[Unsplash.Photo]>> {
            return photosProvider.unsplashRequest(
                PhotosRequestComposer(
                    PhotosRequest(pagination: pagination)
                )
            )
    }

    func photo(with id: String, size: CGSize?, cropRect: CGRect?)
        -> Observable<Unsplash.Response<Unsplash.Photo>> {
            return photosProvider.unsplashRequest(
                PhotosRequestComposer(
                    PhotoRequest(photoID: id, size: size, cropRect: cropRect)
                )
            )
    }
}

// MARK: Users

extension Unsplash {
    func publicProfile(for username: String)
        -> Observable<Unsplash.Response<Unsplash.User>> {
            return usersProvider.unsplashRequest(
                UsersRequestComposer(
                    UserPublicProfileRequest(username: username)
                )
            )
    }

    func userPhotos(for username: String, pagination: Unsplash.PhotosPagination)
        -> Observable<Unsplash.Response<[Unsplash.Photo]>> {
            return usersProvider.unsplashRequest(
                UsersRequestComposer(
                    UserPhotosRequest(username: username, pagination: pagination)
                )
            )
    }

    func userLikedPhotos(for username: String, pagination: Unsplash.PhotosPagination)
        -> Observable<Unsplash.Response<[Unsplash.Photo]>> {
            return usersProvider.unsplashRequest(
                UsersRequestComposer(
                    UserLikedPhotosRequest(username: username, pagination: pagination)
                )
            )
    }
}

// MARK: Search

extension Unsplash {
    func search(by query: String, pagination: Pagination)
        -> Observable<Unsplash.Response<Unsplash.SearchResult<Unsplash.Photo>>> {
            return searchProvider.unsplashRequest(
                SearchRequestComposer(
                    SearchPhotosRequest(query: query, pagination: pagination)
                )
            )
    }
}
