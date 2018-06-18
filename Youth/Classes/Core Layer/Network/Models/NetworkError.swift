//
//  NetworkError.swift
//  Youth
//
//  Created by Lupu Cristian on 4/30/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/**
 Network Error
 */
public enum NetworkError: Error {
    /// No internet connection
    case noInternetConnection

    /// Cancelled request
    case cancelled

    /// Decoding Error
    case decodingError

    /// Response does not contain data
    case noData

    /// Another error
    case another(error: Error)
}
