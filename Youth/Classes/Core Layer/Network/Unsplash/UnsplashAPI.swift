//
//  UnsplashAPI.swift
//  Youth
//
//  Created by Lupu Cristian on 4/30/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Alamofire

public enum UnsplashAPI {
    case photos(page: Int,
                perPage: Int,
                orderBy: UnsplashPhotosOrderBy,
                authorization: UnsplashAuthorization)

    case photo(id: String,
               width: CGFloat?,
               height: CGFloat?,
               cropRect: CGRect?,
               authorization: UnsplashAuthorization)

    case userPublicProfile(username: String,
                           authorization: UnsplashAuthorization)

    case userPhotos(username: String,
                    page: Int,
                    perPage: Int,
                    orderBy: UnsplashPhotosOrderBy,
                    includeStats: Bool,
                    authorization: UnsplashAuthorization)

    case userLikedPhotos(username: String,
                         page: Int,
                         perPage: Int,
                         orderBy: UnsplashPhotosOrderBy,
                         authorization: UnsplashAuthorization)

    case searchPhotos(query: String,
                      page: Int,
                      perPage: Int,
                      authorization: UnsplashAuthorization)
}

extension UnsplashAPI {

    private var authorization: UnsplashAuthorization {
        var authorization: UnsplashAuthorization = .default

        switch self {
        case let .photos(_, _, _, _authorization):
            authorization = _authorization
        case let .photo(_, _, _, _, _authorization):
            authorization = _authorization
        case let .userPublicProfile(_, _authorization):
            authorization = _authorization
        case let .userPhotos(_, _, _, _, _, _authorization):
            authorization = _authorization
        case let .userLikedPhotos(_, _, _, _, _authorization):
            authorization = _authorization
        case let .searchPhotos(_, _, _, _authorization):
            authorization = _authorization
        }

        return authorization
    }

    private var baseURL: URL {
        guard let url = URL(string: "https://api.unsplash.com") else {
            fatalError("Failed to create url from https://api.unsplash.com")
        }
        return url
    }

    private var path: String {
        switch self {
        case .photos:
            return "/photos"
        case let .photo(id, _, _, _, _):
            return "/photos/" + id
        case let .userPublicProfile(username, _):
            return "/users/" + username
        case let .userPhotos(username, _, _, _, _, _):
            return "/users/" + username + "/photos"
        case let .userLikedPhotos(username, _, _, _, _):
            return "/users/" + username + "/likes"
        case .searchPhotos:
            return "/search/photos"
        }
    }

}

extension UnsplashAPI {

    private var endpoint: URL {
        return baseURL.appendingPathComponent(path)
    }

    private var method: Method {
        switch self {
        case .photos,
             .photo,
             .userPublicProfile,
             .userPhotos,
             .userLikedPhotos,
             .searchPhotos:
            return .get
        }
    }

    private var parameters: [String : Any]? {
        switch self {
        case let .photos(page, perPage, orderBy, _):
            var params: [String : Any] = [:]

            params["page"] = page
            params["per_page"] = perPage
            params["order_by"] = orderBy.rawValue

            return params
        case let .photo(_, width, height, cropRect, _):
            var params: [String : Any] = [:]

            if let w = width {
                params["w"] = w
            }

            if let h = height {
                params["h"] = h
            }

            if let rect = cropRect {
                params["rect"] = "\(rect.origin.x),\(rect.origin.y),\(rect.width),\(rect.height)"
            }

            return params
        case let .userPublicProfile(username, _):
            var params: [String : Any] = [:]

            params["username"] = username

            return params
        case let .userPhotos(username, page, perPage, orderBy, includeStats, _):
            var params: [String : Any] = [:]

            params["username"] = username
            params["page"] = page
            params["per_page"] = perPage
            params["order_by"] = orderBy.rawValue
            params["stats"] = includeStats
            params["resolution"] = "days"
            params["quantity"] = 30

            return params
        case let .userLikedPhotos(username, page, perPage, orderBy, _):
            var params: [String : Any] = [:]

            params["username"] = username
            params["page"] = page
            params["per_page"] = perPage
            params["order_by"] = orderBy.rawValue

            return params
        case let .searchPhotos(query, page, perPage, _):
            var params: [String : Any] = [:]

            params["query"] = query
            params["page"] = page
            params["per_page"] = perPage

            return params
        }
    }

    private var encoding: URLEncoding {
        return URLEncoding.default
    }

    public var task: Task {
        return Task(endpoint: endpoint,
                    method: method,
                    parameters: parameters,
                    encoding: encoding,
                    headers: headers)
    }

    public var stubData: Data? {
        switch self {
        case .photos:
            if let url = Bundle.main.url(forResource: "UnsplashPhotosStubResponse", withExtension: "json"),
                let data = try? Data(contentsOf: url) {
                return data
            }
        case .photo:
            if let url = Bundle.main.url(forResource: "UnsplashPhotoStubResponse", withExtension: "json"),
                let data = try? Data(contentsOf: url) {
                return data
            }
        case .userPublicProfile:
            if let url = Bundle.main.url(forResource: "UnsplashUserPublicProfileStubResponse", withExtension: "json"),
                let data = try? Data(contentsOf: url) {
                return data
            }
        case .userPhotos:
            if let url = Bundle.main.url(forResource: "UnsplashUserPhotosStubResponse", withExtension: "json"),
                let data = try? Data(contentsOf: url) {
                return data
            }
        case .userLikedPhotos:
            if let url = Bundle.main.url(forResource: "UnsplashUserLikedPhotosStubResponse", withExtension: "json"),
                let data = try? Data(contentsOf: url) {
                return data
            }
        case .searchPhotos:
            if let url = Bundle.main.url(forResource: "UnsplashSearchPhotosStubResponse", withExtension: "json"),
                let data = try? Data(contentsOf: url) {
                return data
            }
        }
        return nil
    }

    private var headers: [String : String]? {
        var headers: [String : String] = [:]

        headers["Accept-Version"] = "v1"

        switch authorization {
        case let .unauthorizedUser(clientID):
            headers["Authorization"] = "Client-ID \(clientID)"
        case let .authorizedUser(accessToken):
            headers["Authorization"] = "Bearer \(accessToken)"
        }

        return headers
    }
    
}
