//
//  PhotoDetailsInteractor.swift
//  Youth
//
//  Created by Cristian Lupu on 10/06/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

final class PhotoDetailsInteractor {
    // MARK: Output

    weak var output: PhotoDetailsInteractorOutput?

    private let photoProvider: PhotoProvider

    init(photoProvider: PhotoProvider) {
        self.photoProvider = photoProvider
    }
}

// MARK: PhotoDetailsInteractorInput 

extension PhotoDetailsInteractor: PhotoDetailsInteractorInput {
    func obtainPhoto(withID id: String) {
        photoProvider.cancelNetworkRequest()

        photoProvider.photo(id: id, usage: .network) { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }

                switch result {
                case let .success(payload):
                    strongSelf.output?.didObtain(photo: payload, withError: nil)
                case let .failure(error):
                    strongSelf.output?.didObtain(photo: nil, withError: error)
                }
            }
        }
    }
}
