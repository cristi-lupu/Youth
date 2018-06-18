//
//  SearchPhotosViewController.swift
//  Youth
//
//  Created by Lupu Cristian on 01/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit
import SwiftMessages

public final class SearchPhotosViewController: UIViewController {

    deinit {
        // Remove text field observer
        titleView?.textField.removeTarget(nil,
                                          action: nil,
                                          for: .editingChanged)
    }

    // MARK: Output

    public var output: SearchPhotosViewOutput?

    // MARK: Title View

    private weak var titleView: YouthNavigationSearchTitleView?

    // MARK: Layout Bar Button Item

    private weak var layoutBarButtonItem: UIBarButtonItem?

    // MARK: View Controller Life Cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewDidAppear()
    }

    // MARK: Actions

    @objc private func didTapLayoutButton(_ sender: UIBarButtonItem) {
        output?.didTapLayoutButton()
    }

    @objc private func didChangeSearchText(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        output?.didChange(searchText: text)
    }

}

// MARK: SearchPhotosViewInput

extension SearchPhotosViewController: SearchPhotosViewInput {
	
    public func setUpInitialState(collectionLayout: YouthCollectionLayout) {
        view.backgroundColor = .white
        
        let titleView = YouthNavigationSearchTitleView()
        titleView.set(placeholder: "Search Photos")

        // Add text field observer
        titleView.textField.addTarget(self,
                                      action: #selector(didChangeSearchText(_:)),
                                      for: .editingChanged)

        navigationItem.titleView = titleView

        self.titleView = titleView

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

        navigationItem.rightBarButtonItem = layoutBarButton

        layoutBarButtonItem = layoutBarButton
    }

    public func updateState(for collectionLayout: YouthCollectionLayout) {
        switch collectionLayout {
        case .grid:
            layoutBarButtonItem?.image = R.image.actions.layout.layoutGrid()
        case .list:
            layoutBarButtonItem?.image = R.image.actions.layout.layoutList()
        }
    }

    public func showKeyboard() {
        titleView?.textFieldBecomeFirstResponder()
    }

    public func photosCollectionCanvasView() -> UIView {
        return view
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
