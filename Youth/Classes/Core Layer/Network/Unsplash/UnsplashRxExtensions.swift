//
//  UnsplashRxExtensions.swift
//  Youth
//
//  Created by Lupu Cristian on 10/27/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import RxSwift

extension ObservableType {
    @discardableResult
    func unsplashOnFailure(_ block: @escaping (Unsplash.Error) -> Void) -> Observable<E> {
        return self.do(onError: { error in
            if let error = error as? Unsplash.Error {
                block(error)
            } else if let error = error as? RxError {
                block(.rxError(error: error))
            } else {
                block(.undefined(error))
            }
        })
    }
}

extension ObservableType where E: UnsplashResponseType {
    func map<U>(_ transform: @escaping (E.Model) -> U) -> Observable<Unsplash.Response<U>> {
        return map { $0.map(transform) }
    }
}
