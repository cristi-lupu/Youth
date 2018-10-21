//
//  YouthPhotoExifView.swift
//  Youth
//
//  Created by Cristian Lupu on 6/16/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Youth Photo Exif View. Used for showing photo exif
final class YouthPhotoExifView: UIView {
    // MARK: IBoutlets

    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var dimensionsValueLabel: UILabel!
    @IBOutlet weak private var cameraModelValueLabel: UILabel!
    @IBOutlet weak private var focalLengthValueLabel: UILabel!
    @IBOutlet weak private var apertureValueLabel: UILabel!
    @IBOutlet weak private var exposureTimeValueLabel: UILabel!
    @IBOutlet weak private var isoValueLabel: UILabel!

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    // MARK: Private methods

    private func commonInit() {
        backgroundColor = .clear

        Bundle.main.loadNibNamed(String(describing: YouthPhotoExifView.self),
                                 owner: self,
                                 options: nil)

        addSubview(contentView)

        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

// MARK: ViewModelReceiver

extension YouthPhotoExifView: ViewModelReceiver {
    typealias ViewModelType = YouthPhotoExifViewModel

    convenience init(viewModel: YouthPhotoExifViewModel) {
        self.init()
        updateSelf(viewModel: viewModel)
    }

    func updateInConformance(with viewModel: YouthPhotoExifViewModel) {
        updateSelf(viewModel: viewModel)
    }

    private func updateSelf(viewModel: YouthPhotoExifViewModel) {
        dimensionsValueLabel.text = viewModel.photoDimensions
        cameraModelValueLabel.text = viewModel.cameraModel
        focalLengthValueLabel.text = viewModel.focalLength
        apertureValueLabel.text = viewModel.aperture
        exposureTimeValueLabel.text = viewModel.exposureTime
        isoValueLabel.text = viewModel.iso
    }
}
