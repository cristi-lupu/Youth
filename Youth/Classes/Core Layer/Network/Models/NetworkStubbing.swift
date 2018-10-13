//
//  NetworkStubbing.swift
//  Youth
//
//  Created by Cristian Lupu on 4/30/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Network Stubbing. Used only for testing purpose
enum NetworkStubbing {
    
    enum StubbingError: Error {
        case noData
        case decodingError
        case stubbingIsNever
    }
    
    /// Stubbing Never
    case never
    
    /// Stubbing immediately
    case immediately
}
