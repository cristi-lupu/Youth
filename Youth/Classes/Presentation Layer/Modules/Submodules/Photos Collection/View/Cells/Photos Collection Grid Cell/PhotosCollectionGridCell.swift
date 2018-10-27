//
//  PhotosCollectionGridCell.swift
//  Youth
//
//  Created by Cristian Lupu on 5/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.

import Reusable
import UIKit

final class PhotosCollectionGridCell: UICollectionViewCell, NibReusable {
    // MARK: Deinitialization

    deinit {
        imageTapGestureRecognizer?.removeTarget(nil, action: nil)
        imageTapGestureRecognizer = nil
    }

    // MARK: IBOutlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: Public properties

    weak var delegate: PhotosCollectionGridCellDelegate?

    // MARK: Private properties

    private var imageTapGestureRecognizer: UITapGestureRecognizer?

    // MARK: UICollectionViewCell Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 6
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTapGesture(_:)))
        photoImageView.addGestureRecognizer(imageTapGesture)
        imageTapGestureRecognizer = imageTapGesture

        layer.masksToBounds = true
    }

    // MARK: Private methods

    @objc
    func handleImageTapGesture(_ sender: UITapGestureRecognizer) {
        delegate?.didTapImage(on: self)
    }
}

extension PhotosCollectionGridCell {
    func configure(backgroundColor: UIColor, imageURL: URL?) {
        photoImageView.backgroundColor = backgroundColor
        photoImageView.loadImage(with: imageURL)
    }
}
