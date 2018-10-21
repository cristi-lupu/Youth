//
//  UnsplashResult.swift
//  Youth
//
//  Created by Cristian Lupu on 4/30/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Result used as network response in Youth App.
enum UnsplashResult<Model, Failure> where Failure: Error {
    /// Success case. Contains payload and `optional` rate limit from using Unsplash API
    case success(payload: Model, rateLimit: UnsplashRateLimit?)

    /// Failure case
    case failure(Failure)
}
