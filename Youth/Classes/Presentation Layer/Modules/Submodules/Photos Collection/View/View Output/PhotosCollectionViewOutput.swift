//
//  PhotosCollectionViewOutput.swift
//  Youth
//
//  Created by Cristian Lupu on 10/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

protocol PhotosCollectionViewOutput: class {

    func didTapImage(on indexPath: IndexPath)

    func didTouchUpInsideLikeButton(on indexPath: IndexPath)

    func didTouchUpInsideShareButton(on indexPath: IndexPath)

    func didTapDownloadButton(on indexPath: IndexPath)

    func didTapUser(on indexPath: IndexPath)

    func didChangeContentHeight(_ height: CGFloat)

}
