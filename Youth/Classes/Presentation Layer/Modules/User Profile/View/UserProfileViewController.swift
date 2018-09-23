//
//  UserProfileViewController.swift
//  Youth
//
//  Created by Lupu Cristian on 19/05/2018.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit
import SnapKit

final class UserProfileViewController: UIViewController, PhotosCollectionScrollOwner {
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var userInfoView: UIView!
    @IBOutlet weak private var userProfileImageView: UIImageView!
    @IBOutlet weak private var twitterButton: UIButton!
    @IBOutlet weak private var instagramButton: UIButton!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var locationView: UIView!
    @IBOutlet weak private var biographyLabel: UILabel!
    @IBOutlet weak private var likedCountLabel: UILabel!
    @IBOutlet weak private var photosCountLabel: UILabel!
    @IBOutlet weak private var collectionsCountLabel: UILabel!
    @IBOutlet weak private var photosCanvasView: UIView!
    @IBOutlet weak private var userProfileSectionsInfoView: UIView!
    @IBOutlet weak private var likedSectionInfoView: UIView!
    @IBOutlet weak private var photosSectionInfoView: UIView!
    @IBOutlet weak private var collectionsSectionInfoView: UIView!
    @IBOutlet weak private var photosCanvasViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var scrollView: UIScrollView!
    
    // MARK: Output
    
    var output: UserProfileViewOutput?
    
    // MARK: Private properties
    
    var userProfileSectionsViewTopToUserProfileImageViewBottomConstraint: Constraint?
    
    // MARK: PhotosCollectionScrollOwner
    
    weak var photosCollectionScrollingUpdateReceiver: PhotosCollectionScrollingUpdateReceiver?
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }
    
    // MARK: IBActions
    
    @IBAction private func didTouchUpInsideTwitterButton(_ sender: UIButton) {
        output?.didTouchUpInsideTwitterButton()
    }
    
    @IBAction private func didTouchUpInsideInstagramButton(_ sender: UIButton) {
        output?.didTouchUpInsideInstagramButton()
    }
    
    @IBAction private func didTapLikedSection(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
    @IBAction private func didTapPhotosSection(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
    @IBAction private func didTapCollectionsSection(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
}

extension UserProfileViewController: UserProfileViewInput {
    
    func setUpInitialState(withViewModel viewModel: UserProfileViewModel) {
        scrollView.delegate = self
        
        setTitle(withFullName: viewModel.userViewModel.userFullname,
                 username: viewModel.userViewModel.username)
        
        updateUserProfileImage(withURL: viewModel.userViewModel.userAvatarImageURL)
        
        if viewModel.locationIsVisible {
            updateLocation(viewModel.locationViewModel.location)
        } else {
            removeLocation()
        }
        
        if viewModel.biographyIsVisible {
            updateBiography(viewModel.biography)
        } else {
            removeBiography()
        }
        
        updateSection(.liked,
                      state: viewModel.likedSectionState)
        
        updateSection(.photos,
                      state: viewModel.photosSectionState)
        
        updateSection(.collections,
                      state: viewModel.collectionsSectionState)
        
        showTwitterButton(viewModel.twitterButtonIsVisible)
        showInstagramButton(viewModel.instagramButtonIsVisible)
        
        photosCanvasViewHeightConstraint.constant = 0
        
        view.layoutIfNeeded()
    }
    
    func photosCollectionCanvasView() -> UIView {
        return photosCanvasView
    }
    
    func photosCollectionScrollOwner() -> PhotosCollectionScrollOwner? {
        return self
    }
    
    func updatePhotosCollectionCanvasViewHeight(_ height: CGFloat) {
        photosCanvasViewHeightConstraint.constant = height
        view.layoutIfNeeded()
    }
    
}

extension UserProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Avoid user info view
        guard scrollView.contentOffset.y >= userInfoView.frame.height else {
            return
        }
        
        // Removing about user info view and remain only photos collection
        let contentOffset = scrollView.contentOffset.y - userInfoView.frame.height
        let maximumOffset = scrollView.contentSize.height - userInfoView.frame.height - scrollView.frame.size.height
        
        let percentage = contentOffset / maximumOffset
        
        guard percentage >= 0.99 else {
            return
        }
        
        photosCollectionScrollingUpdateReceiver?.didScrollPhotosCollectionAtTheEndOfTheContent()
    }
    
}

extension UserProfileViewController {
    
    private func updateUserProfileImage(withURL url: URL?) {
        guard let url = url else {
            return
        }
        
        userProfileImageView.af_setImage(
            withURL: url,
            imageTransition: .crossDissolve(0.3))
        { [weak self] (dataResponse) in
            guard let strongSelf = self else {
                return
            }
            
            let image = dataResponse.value?.af_imageRoundedIntoCircle()
            strongSelf.userProfileImageView.image = image
        }
    }
    
    private func updateLocation(_ location: String) {
        locationLabel.text = location
    }
    
    private func updateBiography(_ bio: String) {
        biographyLabel.text = bio
    }
    
    private func updateSection(_ section: UserProfileSectionInfo, state: UserProfileSectionInfoState) {
        switch section {
        case .liked:
            switch state {
            case let .count(text):
                likedCountLabel.font = YouthFonts.avenirNextMedium(size: 20).font
                likedCountLabel.text = text
                likedCountLabel.textColor = .black
            case .unknown:
                likedCountLabel.font = YouthFonts.avenirNextMedium(size: 14).font
                likedCountLabel.text = "Unknown"
                likedCountLabel.textColor = UIColor(red: 75 / 255,
                                                    green: 75 / 255,
                                                    blue: 75 / 255,
                                                    alpha: 1.0)
                disableSection(section)
            }
        case .photos:
            switch state {
            case let .count(text):
                photosCountLabel.font = YouthFonts.avenirNextMedium(size: 20).font
                photosCountLabel.text = text
                photosCountLabel.textColor = .black
            case .unknown:
                photosCountLabel.font = YouthFonts.avenirNextMedium(size: 14).font
                photosCountLabel.text = "Unknown"
                photosCountLabel.textColor = UIColor(red: 75 / 255,
                                                     green: 75 / 255,
                                                     blue: 75 / 255,
                                                     alpha: 1.0)
                disableSection(section)
            }
        case .collections:
            switch state {
            case let .count(text):
                collectionsCountLabel.font = YouthFonts.avenirNextMedium(size: 20).font
                collectionsCountLabel.text = text
                collectionsCountLabel.textColor = .black
            case .unknown:
                collectionsCountLabel.font = YouthFonts.avenirNextMedium(size: 14).font
                collectionsCountLabel.text = "Unknown"
                collectionsCountLabel.textColor = UIColor(red: 75 / 255,
                                                          green: 75 / 255,
                                                          blue: 75 / 255,
                                                          alpha: 1.0)
                disableSection(section)
            }
        }
    }
    
    private func disableSection(_ section: UserProfileSectionInfo) {
        switch section {
        case .liked:
            likedSectionInfoView.gestureRecognizers?.forEach {
                $0.removeTarget(nil, action: nil)
                likedSectionInfoView.removeGestureRecognizer($0)
            }
        case .photos:
            photosSectionInfoView.gestureRecognizers?.forEach {
                $0.removeTarget(nil, action: nil)
                photosSectionInfoView.removeGestureRecognizer($0)
            }
        case .collections:
            collectionsSectionInfoView.gestureRecognizers?.forEach {
                $0.removeTarget(nil, action: nil)
                collectionsSectionInfoView.removeGestureRecognizer($0)
            }
        }
    }
    
    private func removeLocation() {
        locationView.removeFromSuperview()
        
        if userInfoView.subviews.contains(where: { (subview) -> Bool in
            subview === biographyLabel
        }) {
            biographyLabel.snp.makeConstraints { (maker) in
                maker.top.equalTo(userProfileImageView.snp.bottom).offset(14)
            }
        } else {
            if userProfileSectionsViewTopToUserProfileImageViewBottomConstraint == nil {
                userProfileSectionsInfoView.snp.makeConstraints { (maker) in
                    userProfileSectionsViewTopToUserProfileImageViewBottomConstraint = maker.top.equalTo(userProfileImageView.snp.bottom).offset(14).constraint
                }
            }
        }
    }
    
    private func removeBiography() {
        biographyLabel.removeFromSuperview()
        
        if userInfoView.subviews.contains(where: { (subview) -> Bool in
            subview === locationView
        }) {
            userProfileSectionsInfoView.snp.makeConstraints { (maker) in
                maker.top.equalTo(locationView.snp.bottom).offset(14)
            }
        } else {
            if userProfileSectionsViewTopToUserProfileImageViewBottomConstraint == nil {
                userProfileSectionsInfoView.snp.makeConstraints { (maker) in
                    userProfileSectionsViewTopToUserProfileImageViewBottomConstraint = maker.top.equalTo(userProfileImageView.snp.bottom).offset(14).constraint
                }
            }
        }
    }
    
    private func showTwitterButton(_ flag: Bool) {
        twitterButton.isHidden = !flag
    }
    
    private func showInstagramButton(_ flag: Bool) {
        instagramButton.isHidden = !flag
    }
    
    private func setTitle(withFullName fullName: String, username: String) {
        let titleView = YouthNavigationTitleSubtitleView()
        titleView.set(title: fullName)
        titleView.set(subtitle: username)
        navigationItem.titleView = titleView
    }
    
}
