//
//  PhotosViewController.swift
//  Youth
//
//  Created by Lupu Cristian on 09/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit
import PinterestSegment
import SwiftMessages

public final class PhotosViewController: UIViewController {

    // MARK: Output

    public var output: PhotosViewOutput?

    // MARK: Layout Bar Button Item

    private weak var layoutBarButtonItem: UIBarButtonItem?

    // MARK: View Controller Life Cycle

    override public func viewDidLoad() {
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
	
    public func setUpInitialState(collectionLayout: YouthCollectionLayout,
                                  photosCategoriesTitles: [String],
                                  photosCategoriesCurrentIndex: Int) {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()

        let searchBarButton = UIBarButtonItem(image: R.image.actions.search(),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapSearchButton(_:)))

        let layoutBarButton: UIBarButtonItem

        switch collectionLayout {
        case .grid:
            layoutBarButton = UIBarButtonItem(image: R.image.actions.layout.layoutGrid(),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapLayoutButton(_:)))
        case .list:
            layoutBarButton = UIBarButtonItem(image: R.image.actions.layout.layoutList(),
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

    public func photosCollectionCanvasView() -> UIView {
        return view
    }

    public func updateState(for collectionLayout: YouthCollectionLayout) {
        switch collectionLayout {
        case .grid:
            layoutBarButtonItem?.image = R.image.actions.layout.layoutGrid()
        case .list:
            layoutBarButtonItem?.image = R.image.actions.layout.layoutList()
        }
    }

    public func showNotification(withText text: String) {
        let notificationView = NotificationView()
        notificationView.set(title: text)

        var config = SwiftMessages.Config()
        config.ignoreDuplicates = true
        config.presentationContext = .view(view)
        config.presentationStyle = .top

        SwiftMessages.show(config: config, view: notificationView)
    }
	
}
