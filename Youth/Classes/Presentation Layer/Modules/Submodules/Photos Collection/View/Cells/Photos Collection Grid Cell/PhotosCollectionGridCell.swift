//
//  PhotosCollectionGridCell.swift
//  Youth
//
//  Created by Lupu Cristian on 5/13/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.

import UIKit
import Alamofire
import AlamofireImage

public final class PhotosCollectionGridCell: UICollectionViewCell, NibReusable {

    // MARK: Deinitialization

    deinit {
        imageTapGestureRecognizer?.removeTarget(nil, action: nil)
        imageTapGestureRecognizer = nil
    }

    // MARK: IBOutlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: Public properties

    public var delegate: PhotosCollectionGridCellDelegate?

    // MARK: Private properties

    private var imageTapGestureRecognizer: UITapGestureRecognizer?

    // MARK: UICollectionViewCell Life Cycle

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 6
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        // https://github.com/jessesquires/JSQMessagesViewController/blob/develop/JSQMessagesViewController/Views/JSQMessagesCollectionViewCell.m
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTapGesture(_:)))
        photoImageView.addGestureRecognizer(imageTapGesture)
        imageTapGestureRecognizer = imageTapGesture

        layer.masksToBounds = true
    }

    // MARK: Private methods

    @objc func handleImageTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.didTapImage(on: self)
    }

}

extension PhotosCollectionGridCell {

    public func configure(backgroundColor: UIColor, imageURL: URL?) {
        photoImageView.backgroundColor = backgroundColor

        if let url = imageURL {
            photoImageView.af_setImage(withURL: url,
                                       imageTransition: .crossDissolve(0.3))
        }
    }

}
