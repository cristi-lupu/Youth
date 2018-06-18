//
//  PhotosCollectionListDataDisplayManager.swift
//  Youth
//
//  Created by Lupu Cristian on 5/13/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

public class PhotosCollectionListDataDisplayManager: NSObject, PhotosCollectionDataDisplayManager {

    public weak var delegate: PhotosCollectionDataDisplayManagerDelegate?

    public private(set) var viewModels: [PhotosCollectionCellViewModel] = []

    public var onUpdateScrollPercentage: ((_ percentage: CGFloat) -> ())?

    public var isLoading = false

    public func updateDataSource(with models: [PhotosCollectionCellViewModel]) {
        viewModels = models
    }

    public func updateDataSourceByInserting(viewModels: [PhotosCollectionCellViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
    }

    public func removeAllDataSource() {
        viewModels.removeAll()
    }

    public func updateViewDownloadingState(atIndex index: Int, withProgress progress: Double, cell: UICollectionViewCell) {
        guard viewModels.indices.contains(index) else {
            return
        }

        viewModels[index].isDownloading = true
        viewModels[index].downloadingProgress = progress

        if let cell = cell as? PhotosCollectionListCell {
            cell.setDownloadingState(withProgress: progress)
        }
    }

    public func updateViewDownloadState(atIndex index: Int, cell: UICollectionViewCell) {
        guard viewModels.indices.contains(index) else {
            return
        }

        viewModels[index].isDownloading = false
        viewModels[index].downloadingProgress = 0.0

        if let cell = cell as? PhotosCollectionListCell {
            cell.setDownloadState()
        }
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isLoading ? 2 : 1
    }

    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModels.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: PhotosCollectionListCell.self)

        let viewModel = viewModels[indexPath.item]

        cell.delegate = self

        cell.configure(imageBackgroundColor: viewModel.backgroundColor,
                       imageURL: viewModel.imageURL,
                       userViewModel: viewModel.userViewModel,
                       likes: viewModel.likes,
                       likedByUser: viewModel.likedByUser)

        if viewModel.isDownloading {
            cell.setDownloadingState(withProgress: viewModel.downloadingProgress)
        } else {
            cell.setDownloadState()
        }

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                               for: indexPath,
                                                               viewType: CollectionLoadingView.self)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               willDisplaySupplementaryView view: UICollectionReusableView,
                               forElementKind elementKind: String,
                               at indexPath: IndexPath) {
        let loadingView = view as? CollectionLoadingView
        loadingView?.startAnimating()
    }

    public func collectionView(_ collectionView: UICollectionView,
                               didEndDisplayingSupplementaryView view: UICollectionReusableView,
                               forElementOfKind elementKind: String,
                               at indexPath: IndexPath) {
        let loadingView = view as? CollectionLoadingView
        loadingView?.stopAnimating()
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        let percentage = contentOffset / maximumOffset

        onUpdateScrollPercentage?(percentage)
    }

}

extension PhotosCollectionListDataDisplayManager: PhotosCollectionViewListLayoutDelegate {

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               imageSizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let viewModel = viewModels[indexPath.item]
        return viewModel.originalPhotoSize
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               additionalHeightAtIndexPath indexPath: IndexPath) -> Float {
        return 8 // image + 8 (distance) + bar
               +
               30 // image + 8 (distance) + 30 (bar)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               heightForHeaderInSection section: Int) -> Float {
        switch section {
        case 1:
            return 50
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout: UICollectionViewLayout,
                               insetForSection section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsetsMake(10, 18, 10, 18)
        default:
            return UIEdgeInsets.zero
        }
    }

}

extension PhotosCollectionListDataDisplayManager: PhotosCollectionListCellDelegate {

    public func didTouchUpInsideLikeButton(on cell: UICollectionViewCell) {
        delegate?.didTouchUpInsideLikeButton?(on: cell)
    }

    public func didTouchUpInsideShareButton(on cell: UICollectionViewCell) {
        delegate?.didTouchUpInsideShareButton?(on: cell)
    }

    public func didTapDownloadButton(on cell: UICollectionViewCell) {
        delegate?.didTapDownloadButton?(on: cell)
    }

    public func didTapUser(on cell: UICollectionViewCell) {
        delegate?.didTapUser?(on: cell)
    }

    public func didTapImage(on cell: UICollectionViewCell) {
        delegate?.didTapImage(on: cell)
    }

}
