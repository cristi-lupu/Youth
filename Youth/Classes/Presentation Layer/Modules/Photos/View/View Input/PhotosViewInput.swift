//
//  PhotosViewInput.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

protocol PhotosViewInput: class {

    func setUpInitialState(collectionLayout: YouthCollectionLayout,
                           photosCategoriesTitles: [String],
                           photosCategoriesCurrentIndex: Int)

    func photosCollectionCanvasView() -> UIView

    func updateState(for collectionLayout: YouthCollectionLayout)

    func showNotification(withText text: String)

}
