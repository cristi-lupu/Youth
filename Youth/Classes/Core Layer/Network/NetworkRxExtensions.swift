//
//  NetworkRxExtensions.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import RxSwift

extension ObservableType {
    @discardableResult
    func onSuccess(_ block: @escaping (E) -> Void) -> Observable<E> {
        return self.do(onNext: block)
    }

    @discardableResult
    func onFailure(_ block: @escaping (Error) -> Void) -> Observable<E> {
        return self.do(onError: block)
    }

    @discardableResult
    func always(_ block: @escaping () -> Void) -> Observable<E> {
        return self.do(onDispose: block)
    }

    @discardableResult
    func then<O>(_ block: @escaping (Self.E) throws -> O) -> Observable<O.E> where O: ObservableConvertibleType {
        return flatMapLatest(block)
    }

    @discardableResult
    func run(
        onNext: ((Self.E) -> Swift.Void)? = nil,
        onError: ((Error) -> Swift.Void)? = nil,
        onCompleted: (() -> Swift.Void)? = nil,
        onDisposed: (() -> Swift.Void)? = nil
    ) -> Disposable {
        return subscribe(onNext: onNext, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
    }
}

extension Disposable {
    @discardableResult
    func disposed(by bag: CompositeDisposable) -> CompositeDisposable.DisposeKey? {
        return bag.insert(self)
    }
}
