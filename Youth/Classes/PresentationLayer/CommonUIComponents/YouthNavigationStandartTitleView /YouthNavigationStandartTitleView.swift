//
//  YouthNavigationStandartTitleView.swift
//  Youth
//
//  Created by Cristian Lupu on 6/12/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Standart Title View. Use as title view with one label.
final class YouthNavigationStandartTitleView: UIView {
    // MARK: Private properties

    private weak var titleLabel: UILabel!

    private var configuredTitleLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = YouthFonts.avenirNextDemiBold(size: 16).font
        return label
    }

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

        let label = configuredTitleLabel

        addSubview(label)

        label.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        snp.makeConstraints { maker in
            maker.height.equalTo(30)
            maker.width.equalTo(220)
        }

        self.titleLabel = label
    }

    // MARK: Public methods

    /**
     Set title
     
     - parameter title: Title string
     */
    func set(title: String) {
        titleLabel.text = title
    }
}
