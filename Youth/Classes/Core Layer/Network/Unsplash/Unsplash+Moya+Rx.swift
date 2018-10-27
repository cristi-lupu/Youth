//
//  Unsplash+Moya+Rx.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya
import Result
import RxSwift

extension MoyaProvider {
    func unsplashRequest<D: Decodable>(_ token: Target) -> Observable<Unsplash.Response<D>> {
        return Observable.create { [weak self] observer in
            guard let welf = self else { return Disposables.create() }
            let cancellableToken = welf.request(token) { [weak self] result in
                self?.unsplashProcess(result, with: observer)
            }

            return Disposables.create(with: cancellableToken.cancel)
        }
    }

    private func unsplashProcess<D: Decodable>(_ result: (Result<Response, MoyaError>),
                                               with observer: AnyObserver<Unsplash.Response<D>>) {
        DispatchQueue.global(qos: .utility).async {
            let response = Result(result)
            let unsplashResult = response.decode(D.self)
            switch unsplashResult {
            case let .success(response):
                DispatchQueue.main.async { observer.onNext(response); observer.onCompleted() }
            case let .failure(error):
                DispatchQueue.main.async { observer.onError(error) }
            }
        }
    }
}
