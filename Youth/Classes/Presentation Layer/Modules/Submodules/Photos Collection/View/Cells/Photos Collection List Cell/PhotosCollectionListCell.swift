//
//  PhotosCollectionListCell.swift
//  Youth
//
//  Created by Cristian Lupu on 5/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

final class PhotosCollectionListCell: UICollectionViewCell, NibReusable {
    // MARK: Deinitialization

    deinit {
        // Remove observers
        imageViewTapGestureRecognizer?.removeTarget(nil, action: nil)
        imageViewTapGestureRecognizer = nil
    }

    // MARK: IBOutlets

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var downloadButton: PKDownloadButton!
    @IBOutlet private weak var userView: YouthUserView!
    @IBOutlet private weak var likesLabel: UILabel!

    // MARK: Private properties

    private weak var imageViewTapGestureRecognizer: UITapGestureRecognizer?

    // MARK: Delegate

    weak var delegate: PhotosCollectionListCellDelegate?

    // MARK: IBActions

    @IBAction private func didTouchUpInsideLikeButton(_ sender: UIButton) {
        delegate?.didTouchUpInsideLikeButton(on: self)
    }

    @IBAction private func didTouchUpInsideShareButton(_ sender: UIButton) {
        delegate?.didTouchUpInsideShareButton(on: self)
    }

    // MARK: UICollectionViewCell Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        userView.delegate = self
        downloadButton.delegate = self

        downloadButton.startDownloadButton.cleanDefaultAppearance()
        downloadButton.startDownloadButton.setImage(UIImage(named: "Actions/download"), for: .normal)

        downloadButton.stopDownloadButton.tintColor = .black
        downloadButton.stopDownloadButton.filledLineWidth = 1.0
        downloadButton.stopDownloadButton.filledLineStyleOuter = true
        downloadButton.stopDownloadButton.radius = 12.5

        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTapGesture(_:)))
        photoImageView.addGestureRecognizer(imageTapGesture)
        imageViewTapGestureRecognizer = imageTapGesture

        photoImageView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = 6
    }

    // MARK: Private methods

    @objc
    private func handleImageTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.didTapImage(on: self)
    }
}

// MARK: PKDownloadButtonDelegate

extension PhotosCollectionListCell: PKDownloadButtonDelegate {
    func downloadButtonTapped(_ downloadButton: PKDownloadButton!,
                              currentState state: PKDownloadButtonState) {
        delegate?.didTapDownloadButton(on: self)
    }
}

// MARK: YouthUserViewDelegate

extension PhotosCollectionListCell: YouthUserViewDelegate {
    func didTapUserView(_ userView: YouthUserView) {
        delegate?.didTapUser(on: self)
    }
}

extension PhotosCollectionListCell {
    func configure(imageBackgroundColor: UIColor,
                   imageURL: URL?,
                   userViewModel: YouthUserViewModel,
                   likes: String,
                   likedByUser: Bool) {
        userView.updateInConformance(with: userViewModel)

        likesLabel.text = likes

        photoImageView.backgroundColor = imageBackgroundColor

        let likeImage: UIImage?

        if likedByUser {
            likeImage = UIImage(named: "Actions/Like/like-selected")
        } else {
            likeImage = UIImage(named: "Actions/Like/like-nonSelected")
        }

        likeButton.setImage(likeImage, for: .normal)
        photoImageView.loadImage(with: imageURL)
    }

    func setDownloadingState(withProgress progress: Double) {
        downloadButton.state = .downloading
        downloadButton.stopDownloadButton.progress = CGFloat(progress)
    }

    func setDownloadState() {
        downloadButton.state = .startDownload
    }
}
