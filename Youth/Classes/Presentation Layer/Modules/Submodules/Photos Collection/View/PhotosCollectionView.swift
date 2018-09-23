//
//  PhotosCollectionView.swift
//  Youth
//
//  Created by Lupu Cristian on 10/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class PhotosCollectionView: UICollectionView, PhotosCollectionScrollOwner {
    
    deinit {
        // Remove Observer
        removeObserver(self,
                       forKeyPath: #keyPath(UICollectionView.contentSize))
    }
    
    // MARK: Output
    
    var output: PhotosCollectionViewOutput?
    
    // MARK: Data Display Manager
    
    private var dataDisplayManager: PhotosCollectionDataDisplayManager?
    
    // MARK: PhotosCollectionScrollingUpdateReceiver
    
    weak var photosCollectionScrollingUpdateReceiver: PhotosCollectionScrollingUpdateReceiver?
    
    // MARK: Private properties
    
    private var oldContentHeight: CGFloat?
    
}

// MARK: PhotosCollectionViewInput

extension PhotosCollectionView: PhotosCollectionViewInput {
    
    func setUpInitialState(withCollectionLayout layout: YouthCollectionLayout) {
        backgroundColor = .white
        indicatorStyle = .black
        
        keyboardDismissMode = .onDrag
        
        registerCell(forCollectionLayout: layout)
        
        let displayManager = dataDisplayManager(forLayout: layout)
        configure(dataDisplayManager: displayManager)
        
        self.dataDisplayManager = displayManager
        
        delegate = dataDisplayManager
        dataSource = dataDisplayManager
        
        collectionViewLayout = collectionViewLayout(forCollectionLayout: layout)
        
        register(supplementaryViewType: CollectionLoadingView.self,
                 ofKind: UICollectionView.elementKindSectionHeader)
        
        addContentSizeObserver()
        
        dataDisplayManager?.updateDataSource(with: [])
        dataDisplayManager?.isLoading = false
        reloadData()
    }
    
    func updateState(with viewModels: [PhotosCollectionCellViewModel]) {
        dataDisplayManager?.removeAllDataSource()
        dataDisplayManager?.updateDataSource(with: viewModels)
        reloadData()
        setContentOffset(CGPoint.zero, animated: false)
    }
    
    func updateStateByAdding(viewModels: [PhotosCollectionCellViewModel]) {
        performBatchUpdates({ [weak self] in
            guard let strongSelf = self,
                let dataDisplayManager = strongSelf.dataDisplayManager else {
                    return
            }
            
            let currentCount = dataDisplayManager.viewModels.count
            let toCount = currentCount + viewModels.count
            
            let indexPaths = (currentCount..<toCount).map {
                IndexPath(item: $0, section: 0)
            }
            
            strongSelf.insertItems(at: indexPaths)
            dataDisplayManager.updateDataSourceByInserting(viewModels: viewModels)
        })
    }
    
    func changeLayout(_ layout: YouthCollectionLayout) {
        guard let viewModels = dataDisplayManager?.viewModels,
            let isLoading = dataDisplayManager?.isLoading else {
                return
        }
        
        let median = medianIndexPath
        
        dataDisplayManager?.removeAllDataSource()
        
        registerCell(forCollectionLayout: layout)
        
        let displayManager = dataDisplayManager(forLayout: layout)
        configure(dataDisplayManager: displayManager)
        
        displayManager.isLoading = isLoading
        
        self.dataDisplayManager = displayManager
        
        delegate = dataDisplayManager
        dataSource = dataDisplayManager
        
        collectionViewLayout = collectionViewLayout(forCollectionLayout: layout)
        
        dataDisplayManager?.updateDataSource(with: viewModels)
        
        reloadData()
        
        if let medianIndexPath = median {
            scrollToItem(at: medianIndexPath,
                         at: .centeredVertically,
                         animated: false)
        }
    }
    
    func set(scrollEnabled: Bool) {
        isScrollEnabled = scrollEnabled
    }
    
    func showBottomLoading() {
        guard let dataDisplayManager = dataDisplayManager,
            !dataDisplayManager.isLoading else {
                return
        }
        
        performBatchUpdates({
            dataDisplayManager.isLoading = true
            insertSections(IndexSet(integer: 1))
        })
    }
    
    func hideBottomLoading() {
        guard let dataDisplayManager = dataDisplayManager,
            dataDisplayManager.isLoading else {
                return
        }
        
        performBatchUpdates({
            dataDisplayManager.isLoading = false
            deleteSections(IndexSet(integer: 1))
        })
    }
    
    func updateDownloadingStateOfPhoto(atIndex index: Int, progress: Double) {
        guard let cell = cellForItem(at: IndexPath(item: index, section: 0)) else {
            return
        }
        
        dataDisplayManager?.updateViewDownloadingState(atIndex: index, withProgress: progress, cell: cell)
    }
    
    func setDownloadState(atIndex index: Int) {
        guard let cell = cellForItem(at: IndexPath(item: index, section: 0)) else {
            return
        }
        
        dataDisplayManager?.updateViewDownloadState(atIndex: index, cell: cell)
    }
    
}

// MARK: PhotosCollectionDataDisplayManagerDelegate

extension PhotosCollectionView: PhotosCollectionDataDisplayManagerDelegate {
    
    func didTapImage(on cell: UICollectionViewCell) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }
        
        output?.didTapImage(on: indexPath)
    }
    
    @objc func didTouchUpInsideLikeButton(on cell: UICollectionViewCell) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }
        
        output?.didTouchUpInsideLikeButton(on: indexPath)
    }
    
    @objc func didTouchUpInsideShareButton(on cell: UICollectionViewCell) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }
        
        output?.didTouchUpInsideShareButton(on: indexPath)
    }
    
    @objc func didTapDownloadButton(on cell: UICollectionViewCell) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }
        
        output?.didTapDownloadButton(on: indexPath)
    }
    
    @objc func didTapUser(on cell: UICollectionViewCell) {
        guard let indexPath = indexPath(for: cell) else {
            return
        }
        
        output?.didTapUser(on: indexPath)
    }
    
}

// MARK: NSObject observer

extension PhotosCollectionView {
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case #keyPath(UICollectionView.contentSize):
            if let contentHeight = oldContentHeight {
                let height = collectionViewLayout.collectionViewContentSize.height
                if contentHeight != height {
                    oldContentHeight = height
                    output?.didChangeContentHeight(height)
                }
            } else {
                let height = collectionViewLayout.collectionViewContentSize.height
                oldContentHeight = height
                output?.didChangeContentHeight(height)
            }
        default:
            break
        }
    }
    
}

// MARK: Private methods

extension PhotosCollectionView {
    
    private func addContentSizeObserver() {
        addObserver(self,
                    forKeyPath: #keyPath(UICollectionView.contentSize),
                    options: [.initial, .new],
                    context: nil)
    }
    
    private func dataDisplayManager(forLayout layout: YouthCollectionLayout) -> PhotosCollectionDataDisplayManager {
        let displayManager: PhotosCollectionDataDisplayManager
        
        switch layout {
        case .grid:
            displayManager = PhotosCollectionGridDataDisplayManager()
        case .list:
            displayManager = PhotosCollectionListDataDisplayManager()
        }
        
        return displayManager
    }
    
    private func configure(dataDisplayManager: PhotosCollectionDataDisplayManager) {
        dataDisplayManager.delegate = self
        
        dataDisplayManager.onUpdateScrollPercentage = { [weak self] (percentage) in
            guard let strongSelf = self,
                percentage >= 0.99 else {
                    return
            }
            
            strongSelf.photosCollectionScrollingUpdateReceiver?.didScrollPhotosCollectionAtTheEndOfTheContent()
        }
    }
    
    private func registerCell(forCollectionLayout layout: YouthCollectionLayout) {
        switch layout {
        case .grid:
            register(cellType: PhotosCollectionGridCell.self)
        case .list:
            register(cellType: PhotosCollectionListCell.self)
        }
    }
    
    private func collectionViewLayout(forCollectionLayout layout: YouthCollectionLayout) -> UICollectionViewLayout {
        let collectionViewLayout: UICollectionViewLayout
        
        switch layout {
        case .grid:
            let gridLayout = PhotosCollectionViewGridLayout()
            gridLayout.columnCount = 2
            gridLayout.minimumColumnSpacing = 14
            gridLayout.minimumInteritemSpacing = 14
            collectionViewLayout = gridLayout
        case .list:
            let listLayout = PhotosCollectionViewListLayout()
            listLayout.minimumColumnSpacing = 14
            listLayout.minimumInteritemSpacing = 14
            collectionViewLayout = listLayout
        }
        
        return collectionViewLayout
    }
    
    private var medianIndexPath: IndexPath? {
        guard contentOffset.y > 0,
            indexPathsForVisibleItems.count > 0 else {
                return nil
        }
        
        let sortedIndexPaths = indexPathsForVisibleItems.sorted(by: <)
        let medianIndex = sortedIndexPaths.count / 2
        let medianIndexPath = sortedIndexPaths[medianIndex]
        
        return medianIndexPath
    }
    
}
