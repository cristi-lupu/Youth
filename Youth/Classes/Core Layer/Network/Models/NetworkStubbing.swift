//
//  NetworkStubbing.swift
//  Youth
//
//  Created by Lupu Cristian on 4/30/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Network Stubbing. Used only for testing purpose
public enum NetworkStubbing {

    public enum StubbingError: Error {
        case noData
        case decodingError
        case stubbingIsNever
    }

    /// Stubbing Never
    case never

    /// Stubbing immediately
    case immediately
}
