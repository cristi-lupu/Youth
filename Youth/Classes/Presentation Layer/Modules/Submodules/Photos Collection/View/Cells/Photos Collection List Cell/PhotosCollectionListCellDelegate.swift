//
//  PhotosCollectionListCellDelegate.swift
//  Youth
//
//  Created by Lupu Cristian on 5/20/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Responsible to receive PhotosCollectionListCell actions
public protocol PhotosCollectionListCellDelegate: PhotosCollectionCellDelegate {

    /**
     Did Touch Up Inside Like Button

     - parameter cell: Cell tapped
    */
    func didTouchUpInsideLikeButton(on cell: UICollectionViewCell)

    /**
     Did Touch Up Inside Share Button

     - parameter cell: Cell tapped
     */
    func didTouchUpInsideShareButton(on cell: UICollectionViewCell)

    /**
     Did Tap Download Button

     - parameter cell: Cell tapped
     */
    func didTapDownloadButton(on cell: UICollectionViewCell)

    /**
     Did Tap User

     - parameter cell: Cell tapped
     */
    func didTapUser(on cell: UICollectionViewCell)

}
