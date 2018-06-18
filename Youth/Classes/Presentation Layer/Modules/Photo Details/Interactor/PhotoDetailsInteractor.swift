//
//  PhotoDetailsInteractor.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public final class PhotoDetailsInteractor {

	// MARK: Output

    public weak var output: PhotoDetailsInteractorOutput?

    private let photoProvider: PhotoProvider

    public init(photoProvider: PhotoProvider) {
        self.photoProvider = photoProvider
    }

}

// MARK: PhotoDetailsInteractorInput 

extension PhotoDetailsInteractor: PhotoDetailsInteractorInput {

    public func obtainPhoto(withID id: String) {
        photoProvider.cancelNetworkRequest()

        photoProvider.photo(id: id, usage: .network) { [weak self] (result) in
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
