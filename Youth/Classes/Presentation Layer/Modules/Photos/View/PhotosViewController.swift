//
//  PhotosViewController.swift
//  Youth
//
//  Created by Cristian Lupu on 09/05/2018.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit
import PinterestSegment
import SwiftMessages

final class PhotosViewController: UIViewController {
    
    // MARK: Output
    
    var output: PhotosViewOutput?
    
    // MARK: Layout Bar Button Item
    
    private weak var layoutBarButtonItem: UIBarButtonItem?
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    // MARK: Actions
    
    @objc private func didTapSearchButton(_ sender: UIBarButtonItem) {
        output?.didTapSearchButton()
    }
    
    @objc private func didTapLayoutButton(_ sender: UIBarButtonItem) {
        output?.didTapLayoutButton()
    }
    
    @objc private func segmentedControlDidChangeIndex(_ sender: PinterestSegment) {
        output?.didChangePhotosCategory(at: sender.selectIndex)
    }
    
}

extension PhotosViewController: PhotosViewInput {
    
    func setUpInitialState(collectionLayout: YouthCollectionLayout,
                           photosCategoriesTitles: [String],
                           photosCategoriesCurrentIndex: Int) {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let searchBarButton = UIBarButtonItem(image: UIImage(named: "Actions/search"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapSearchButton(_:)))
        
        let layoutBarButton: UIBarButtonItem
        
        switch collectionLayout {
        case .grid:
            layoutBarButton = UIBarButtonItem(image: UIImage(named: "Actions/Layout/layout-grid"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapLayoutButton(_:)))
        case .list:
            layoutBarButton = UIBarButtonItem(image: UIImage(named: "Actions/Layout/layout-list"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapLayoutButton(_:)))
        }
        
        navigationItem.rightBarButtonItems = [searchBarButton, layoutBarButton]
        
        layoutBarButtonItem = layoutBarButton
        
        var style = PinterestSegmentStyle()
        style.titleMargin = 1
        style.titleFont = YouthFonts.avenirNextDemiBold(size: 14).font
        style.indicatorColor = .black
        style.normalTitleColor = .black
        style.selectedTitleColor = .white
        style.titlePendingHorizontal = 10
        style.titlePendingVertical = 8
        
        let segmentedControl = PinterestSegment(frame: CGRect(x: 0, y: 0, width: 200, height: 30),
                                                segmentStyle: style,
                                                titles: photosCategoriesTitles)
        
        segmentedControl.setSelectIndex(index: photosCategoriesCurrentIndex,
                                        animated: false)
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChangeIndex(_:)),
                                   for: .valueChanged)
        
        let segmentedControlBarButtonItem = UIBarButtonItem(customView: segmentedControl)
        navigationItem.leftBarButtonItem = segmentedControlBarButtonItem
    }
    
    func photosCollectionCanvasView() -> UIView {
        return view
    }
    
    func updateState(for collectionLayout: YouthCollectionLayout) {
        switch collectionLayout {
        case .grid:
            layoutBarButtonItem?.image = UIImage(named: "Actions/Layout/layout-grid")
        case .list:
            layoutBarButtonItem?.image = UIImage(named: "Actions/Layout/layout-list")
        }
    }
    
    func showNotification(withText text: String) {
        let notificationView = NotificationView()
        notificationView.set(title: text)
        
        var config = SwiftMessages.Config()
        config.ignoreDuplicates = true
        config.presentationContext = .view(view)
        config.presentationStyle = .top
        
        SwiftMessages.show(config: config, view: notificationView)
    }
    
}
