//
//  Unsplash+Result.swift
//  Youth
//
//  Created by Cristian Lupu on 10/14/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya
import Result

extension Result where Value == Unsplash.Response<Data>, Error == Unsplash.Error {
    func decode<D: Decodable>(_ type: D.Type) -> Result<Unsplash.Response<D>, Unsplash.Error> {
        return flatMap { response in
            do {
                let model = try JSONDecoder().decode(D.self, from: response.model)
                let response = Unsplash.Response(model: model, statusCode: response.statusCode,
                                                 request: response.request, response: response.response)

                return .success(response)
            } catch let error as DecodingError {
                return .failure(.decoding(code: response.statusCode, error: error))
            } catch let error as NSError {
                return .failure(.underlying(error, code: error.code, data: nil))
            } catch {
                return .failure(.underlying(error, code: nil, data: nil))
            }
        }
    }
}

extension Result where Value == Unsplash.Response<Data>, Error == Unsplash.Error {
    init(_ result: Result<Moya.Response, Moya.MoyaError>) {
        switch result {
        case .success(let response):
            self = .success(Unsplash.Response(moyaResponse: response))
        case .failure(let error):
            self = .failure(Unsplash.Error(moyaError: error))
        }
    }
}
