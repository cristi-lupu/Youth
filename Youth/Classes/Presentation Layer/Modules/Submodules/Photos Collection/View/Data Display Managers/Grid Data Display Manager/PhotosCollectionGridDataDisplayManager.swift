//
//  PhotosCollectionGridDataDisplayManager.swift
//  Youth
//
//  Created by Lupu Cristian on 5/10/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class PhotosCollectionGridDataDisplayManager: NSObject, PhotosCollectionDataDisplayManager {
    
    weak var delegate: PhotosCollectionDataDisplayManagerDelegate?
    
    private(set) var viewModels: [PhotosCollectionCellViewModel] = []
    
    var onUpdateScrollPercentage: ((_ percentage: CGFloat) -> ())?
    
    var isLoading = false
    
    func updateDataSource(with models: [PhotosCollectionCellViewModel]) {
        viewModels = models
    }
    
    func updateDataSourceByInserting(viewModels: [PhotosCollectionCellViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
    }
    
    func removeAllDataSource() {
        viewModels.removeAll()
    }
    
    func updateViewDownloadingState(atIndex index: Int, withProgress progress: Double, cell: UICollectionViewCell) {
        guard viewModels.indices.contains(index) else {
            return
        }
        
        viewModels[index].isDownloading = true
        viewModels[index].downloadingProgress = progress
    }
    
    func updateViewDownloadState(atIndex index: Int, cell: UICollectionViewCell) {
        guard viewModels.indices.contains(index) else {
            return
        }
        
        viewModels[index].isDownloading = false
        viewModels[index].downloadingProgress = 0.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isLoading ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModels.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: PhotosCollectionGridCell.self)
        
        let viewModel = viewModels[indexPath.item]
        
        cell.delegate = self
        
        cell.configure(backgroundColor: viewModel.backgroundColor,
                       imageURL: viewModel.imageURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                               for: indexPath,
                                                               viewType: CollectionLoadingView.self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        let loadingView = view as? CollectionLoadingView
        loadingView?.startAnimating()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String,
                        at indexPath: IndexPath) {
        let loadingView = view as? CollectionLoadingView
        loadingView?.stopAnimating()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        let percentage = contentOffset / maximumOffset
        
        onUpdateScrollPercentage?(percentage)
    }
    
}

extension PhotosCollectionGridDataDisplayManager: PhotosCollectionViewGridLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        imageSizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let viewModel = viewModels[indexPath.item]
        return viewModel.originalPhotoSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        heightForHeaderInSection section: Int) -> Float {
        switch section {
        case 1:
            return 50
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        insetForSection section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
        default:
            return .zero
        }
    }
    
}

extension PhotosCollectionGridDataDisplayManager: PhotosCollectionGridCellDelegate {
    
    func didTapImage(on cell: UICollectionViewCell) {
        delegate?.didTapImage(on: cell)
    }
    
}
