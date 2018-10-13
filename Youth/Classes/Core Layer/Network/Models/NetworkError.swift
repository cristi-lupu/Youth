//
//  NetworkError.swift
//  Youth
//
//  Created by Cristian Lupu on 4/30/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/**
 Network Error
 */
enum NetworkError: Error {
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
