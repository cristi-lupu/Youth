//
//  UnsplashError.swift
//  Youth
//
//  Created by Cristian Lupu on 10/14/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya
import RxSwift

extension Unsplash {
    enum Error: Swift.Error, Equatable, CustomDebugStringConvertible {
        case unauthenticatedUser
        case noInternetConnection
        case rxError(error: RxError)
        case decoding(code: Int, error: DecodingError)
        case imageMapping(code: Int, data: Data)
        case jsonMapping(code: Int, data: Data)
        case stringMapping(code: Int, data: Data)
        case statusCode(code: Int, data: Data)
        case requestMapping(String)
        case objectMapping(Swift.Error)
        case encodableMapping(Swift.Error)
        case parameterEncoding(Swift.Error)
        case underlying(Swift.Error, code: Int?, data: Data?)
        case undefined(Swift.Error)

        init(moyaError: Moya.MoyaError) {
            switch moyaError {
            case .imageMapping(let response):
                self = .imageMapping(code: response.statusCode, data: response.data)
            case .jsonMapping(let response):
                self = .jsonMapping(code: response.statusCode, data: response.data)
            case .stringMapping(let response):
                self = .stringMapping(code: response.statusCode, data: response.data)
            case .statusCode(let response):
                self = .statusCode(code: response.statusCode, data: response.data)
            case .underlying(let error, let response):
                self = .underlying(error, code: response?.statusCode, data: response?.data)
            case .requestMapping(let url):
                self = .requestMapping(url)
            case .objectMapping(let error, _):
                self = .objectMapping(error)
            case .encodableMapping(let error):
                self = .encodableMapping(error)
            case .parameterEncoding(let error):
                self = .parameterEncoding(error)
            }
        }

        // swiftlint:disable:next cyclomatic_complexity
        static func == (lhs: Error, rhs: Error) -> Bool {
            switch (lhs, rhs) {
            case (.decoding(let code1, let decodeError1), .decoding(let code2, let decodeError2)):
                return code1 == code2 && decodeError1 == decodeError2
            case (.imageMapping(let code1, let data1), .imageMapping(let code2, let data2)):
                return code1 == code2 && data1 == data2
            case (.jsonMapping(let code1, let data1), .jsonMapping(let code2, let data2)):
                return code1 == code2 && data1 == data2
            case (.stringMapping(let code1, let data1), .stringMapping(let code2, let data2)):
                return code1 == code2 && data1 == data2
            case (.statusCode(let code1, let data1), .statusCode(let code2, let data2)):
                return code1 == code2 && data1 == data2
            case (.requestMapping(let error1), .requestMapping(let error2)):
                return error1 == error2
            case (.underlying(let error1, let code1, let data1), .underlying(let error2, let code2, let data2)):
                return error1.localizedDescription == error2.localizedDescription && code1 == code2 && data1 == data2
            case (.unauthenticatedUser, .unauthenticatedUser):
                return true
            case (.noInternetConnection, .noInternetConnection):
                return true
            case (.rxError(let error1), .rxError(let error2)):
                return error1 == error2
            case (.objectMapping(let error1), .objectMapping(let error2)):
                return error1.localizedDescription == error2.localizedDescription
            case (.encodableMapping(let error1), .encodableMapping(let error2)):
                return error1.localizedDescription == error2.localizedDescription
            case (.parameterEncoding(let error1), .parameterEncoding(let error2)):
                return error1.localizedDescription == error2.localizedDescription
            case (.undefined, .undefined):
                return true
            default: return false
            }
        }

        var debugDescription: String {
            switch self {
            case .decoding(_, let decodingError): return decodingError.debugDescription
            case .imageMapping: return "Error while mapping image from data."
            case .jsonMapping: return "Error while mapping json from data."
            case .stringMapping: return "Error while mapping string from data."
            case .statusCode(let code, _): return "Status code: \(code)"
            case .requestMapping(let error): return error
            case .underlying(let error, _, _): return error.localizedDescription
            case .unauthenticatedUser: return "User is not authenticated."
            case .noInternetConnection: return "Missing internet connectivity."
            case .rxError(let error): return "RxError: \(error)"
            case .undefined(let error): return "Undefined error: \(error)"
            case .objectMapping(let error): return "Object mapping error: \(error.localizedDescription)"
            case .encodableMapping(let error): return "Encodable mapping error: \(error.localizedDescription)"
            case .parameterEncoding(let error): return "Parameter encoding error: \(error.localizedDescription)"
            }
        }
    }
}

extension DecodingError.Context: Equatable {
    public static func == (lhs: DecodingError.Context, rhs: DecodingError.Context) -> Bool {
        return lhs.codingPath.map { $0.stringValue } == rhs.codingPath.map { $0.stringValue }
    }
}

extension DecodingError: Equatable {
    public static func == (lhs: DecodingError, rhs: DecodingError) -> Bool {
        switch (lhs, rhs) {
        case (.typeMismatch(_, let context1), .typeMismatch(_, let context2)):
            return context1 == context2
        case (.valueNotFound(_, let context1), .valueNotFound(_, let context2)):
            return context1 == context2
        case (.keyNotFound(let key1, let context1), .keyNotFound(let key2, let context2)):
            return key1.stringValue == key2.stringValue && context1 == context2
        case (.dataCorrupted(let context1), .dataCorrupted(let context2)):
            return context1 == context2
        default: return false
        }
    }
}

extension DecodingError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .typeMismatch(let type, let context):
            return "Type \(type) mismatch, context: \(context.debugDescription)"
        case .valueNotFound(let type, let context):
            return "Value of type \(type) not found, context: \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            return "Key \(key) not found, context: \(context.debugDescription)"
        case .dataCorrupted(let context):
            return "Data corrupted, context: \(context.debugDescription)"
        }
    }
}

extension RxError: Equatable {
    public static func == (lhs: RxError, rhs: RxError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown): return true
        case (.disposed, .disposed): return true
        case (.overflow, .overflow): return true
        case (.argumentOutOfRange, .argumentOutOfRange): return true
        case (.noElements, .noElements): return true
        case (.moreThanOneElement, .moreThanOneElement): return true
        case (.timeout, .timeout): return true
        default: return false
        }
    }
}
