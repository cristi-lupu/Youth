//
//  PhotosCollectionDataDisplayManager.swift
//  Youth
//
//  Created by Cristian Lupu on 5/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Responsible to receive all photos collection actions
@objc protocol PhotosCollectionDataDisplayManagerDelegate: class {
    /**
     Did tap image
     
     - parameter cell: Cell tapped
     */
    func didTapImage(on cell: UICollectionViewCell)

    /**
     Did touch up inside like button
     
     - parameter cell: Cell tapped
     */
    @objc
    optional func didTouchUpInsideLikeButton(on cell: UICollectionViewCell)

    /**
     Did touch up inside share button
     
     - parameter cell: Cell tapped
     */
    @objc
    optional func didTouchUpInsideShareButton(on cell: UICollectionViewCell)

    /**
     Did tap download button
     
     - parameter cell: Cell tapped
     */
    @objc
    optional func didTapDownloadButton(on cell: UICollectionViewCell)

    /**
     Did tap user
     
     - parameter cell: Cell tapped
     */
    @objc
    optional func didTapUser(on cell: UICollectionViewCell)
}

/// Responsible to manage data source and displaying of Photos Collection
protocol PhotosCollectionDataDisplayManager: UICollectionViewDataSource, UICollectionViewDelegate {
    /// View Models for binding with cells
    var viewModels: [PhotosCollectionCellViewModel] { get }

    /// Delegate
    var delegate: PhotosCollectionDataDisplayManagerDelegate? { get set }

    /// Bool what indicates if need to show 2-nd section with CollectionLoading Header
    var isLoading: Bool { get set }

    /// Percentage range: ˜-0.1 - ˜1.1
    var onUpdateScrollPercentage: ((_ percentage: CGFloat) -> Void)? { get set }

    /**
     Update data source with new models. Will be removed all old models
     
     - parameter models: New Models
     */
    func updateDataSource(with models: [PhotosCollectionCellViewModel])

    /**
     Update data source by inserting new models at end.
     
     - parameter models: New Models
     */
    func updateDataSourceByInserting(viewModels: [PhotosCollectionCellViewModel])

    /**
     Update view cell with following downloading state
     
     - parameter index: Index where view model of cell is founded
     - parameter progress: Download Progress
     - parameter cell: View to update
     */
    func updateViewDownloadingState(atIndex index: Int, withProgress progress: Double, cell: UICollectionViewCell)

    /**
     Update view cell with download state
     
     - parameter index: Index where view model of cell is founded
     - parameter cell: View to update
     */
    func updateViewDownloadState(atIndex index: Int, cell: UICollectionViewCell)

    /// Remove all data source
    func removeAllDataSource()
}
