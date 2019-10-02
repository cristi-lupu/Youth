//
//  PhotoDetailsInteractor.swift
//  Youth
//
//  Created by Cristian Lupu on 10/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import RxSwift

final class PhotoDetailsInteractor {
    // MARK: Output

    weak var output: PhotoDetailsInteractorOutput?

    private let unsplash: UnsplashType
    private let disposeBag = DisposeBag()

    init(unsplash: UnsplashType) {
        self.unsplash = unsplash
    }
}

// MARK: PhotoDetailsInteractorInput 

extension PhotoDetailsInteractor: PhotoDetailsInteractorInput {
    func obtainPhoto(withID id: String) {
        unsplash.photo(with: id)
            .onSuccess { [weak self] in self?.output?.didObtain(photo: $0.model, withError: nil) }
            .unsplashOnFailure { [weak self] in self?.output?.didObtain(photo: nil, withError: $0) }
            .run().disposed(by: disposeBag)
    }
}
