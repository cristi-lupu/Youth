//
//  UnsplashType.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import RxSwift

protocol UnsplashType: class {
    // MARK: Photos

    func photos(with pagination: Unsplash.PhotosPagination)
        -> Observable<Unsplash.Response<[Unsplash.Photo]>>

    func photo(with id: String, size: CGSize?, cropRect: CGRect?)
        -> Observable<Unsplash.Response<Unsplash.Photo>>

    // MARK: Users

    func publicProfile(for username: String)
        -> Observable<Unsplash.Response<Unsplash.User>>

    func userPhotos(for username: String, pagination: Unsplash.PhotosPagination)
        -> Observable<Unsplash.Response<[Unsplash.Photo]>>

    func userLikedPhotos(for username: String, pagination: Unsplash.PhotosPagination)
        -> Observable<Unsplash.Response<[Unsplash.Photo]>>

    // MARK: Search

    func search(by query: String, pagination: Pagination)
        -> Observable<Unsplash.Response<Unsplash.SearchResult<Unsplash.Photo>>>
}

// MARK: Photos Extensions

extension UnsplashType {
    func photo(with id: String)
        -> Observable<Unsplash.Response<Unsplash.Photo>> {
        return photo(with: id, size: nil, cropRect: nil)
    }
}
