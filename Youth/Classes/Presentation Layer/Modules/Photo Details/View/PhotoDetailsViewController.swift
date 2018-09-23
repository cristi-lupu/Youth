//
//  PhotoDetailsViewController.swift
//  Youth
//
//  Created by Lupu Cristian on 10/06/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

final class PhotoDetailsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var photoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var userView: YouthUserView!
    @IBOutlet weak private var locationView: YouthLocationView!
    @IBOutlet weak private var exifView: YouthPhotoExifView!
    
    // MARK: Output
    
    var output: PhotoDetailsViewOutput?
    
    // MARK: Private properties
    
    private var photoSize: CGSize = .zero
    
    private var refreshControl: UIRefreshControl?
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Set corner radius
        photoImageView.layer.cornerRadius = 6
        
        guard photoSize != .zero else {
            return
        }
        
        // Scope of line bellow is to get actual size of photo image view in conformance with AutoLayout,
        // otherwise photo image view width (property of frame) will be smaller than real from AutoLayout
        view.layoutIfNeeded()
        
        // Update photo height
        let photoHeight = photoSize.height * photoImageView.frame.width / photoSize.width
        photoImageViewHeightConstraint.constant = photoHeight
        
        // To update constant of constraint
        view.layoutIfNeeded()
    }
    
}

extension PhotoDetailsViewController: YouthUserViewDelegate {
    
    func didTapUserView(_ userView: YouthUserView) {
        output?.didTapUser()
    }
    
}

extension PhotoDetailsViewController: PhotoDetailsViewInput {
    
    func setUpInitialState(title: String) {
        photoImageView.layer.masksToBounds = true
        
        userView.delegate = self
        
        let titleView = YouthNavigationStandartTitleView()
        titleView.set(title: title)
        navigationItem.titleView = titleView
    }
    
    func updateState(withViewModel viewModel: PhotoDetailsViewModel) {
        userView.updateInConformance(with: viewModel.userViewModel)
        
        locationView.updateInConformance(with: viewModel.locationViewModel)
        
        exifView.updateInConformance(with: viewModel.exifViewModel)
        
        photoImageView.backgroundColor = viewModel.photoBackgroundColor
        
        if let url = viewModel.photoURL {
            photoImageView.af_setImage(withURL: url,
                                       imageTransition: .crossDissolve(0.3))
        }
        
        photoSize = viewModel.photoSize
        
        view.setNeedsLayout()
    }
    
    func showTopLoading() {
        if let refresh = refreshControl {
            if refresh.isRefreshing {
                refresh.endRefreshing()
            }
            refresh.removeFromSuperview()
            refreshControl = nil
        }
        
        refreshControl = UIRefreshControl()
        scrollView.addSubview(refreshControl!)
        
        refreshControl?.beginRefreshing()
    }
    
    func hideTopLoading() {
        refreshControl?.endRefreshing()
        refreshControl?.removeFromSuperview()
        refreshControl = nil
        scrollView.setContentOffset(.zero, animated: false)
    }
    
}
