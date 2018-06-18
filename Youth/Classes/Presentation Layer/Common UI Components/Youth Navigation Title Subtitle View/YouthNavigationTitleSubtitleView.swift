//
//  YouthNavigationTitleSubtitleView.swift
//  Youth
//
//  Created by Lupu Cristian on 5/20/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Navigation Title Subtitle View. Use as title view with main and secondary labels.
public final class YouthNavigationTitleSubtitleView: UIView {

    // MARK: Private properties

    private weak var titleLabel: UILabel!
    private weak var subtitleLabel: UILabel!

    private var configuredStackView: UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }

    private var configuredTitleLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = YouthFonts.avenirNextBold(size: 12).font
        label.textColor = .black
        return label
    }

    private var configuredSubtitleLabel: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = YouthFonts.avenirNextRegular(size: 10).font
        label.textColor = .black
        return label
    }

    // MARK: Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: Private methods

    private func commonInit() {
        backgroundColor = .clear

        let stackView = configuredStackView

        addSubview(stackView)

        stackView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }

        let titleLabel = configuredTitleLabel

        stackView.addArrangedSubview(titleLabel)

        let subtitleLabel = configuredSubtitleLabel

        stackView.addArrangedSubview(subtitleLabel)

        snp.makeConstraints { (maker) in
            maker.height.equalTo(30)
            maker.width.equalTo(180)
        }

        self.titleLabel = titleLabel
        self.subtitleLabel = subtitleLabel
    }

    // MARK: Public methods

    /**
     Set title

     - parameter title: Title string
     */
    public func set(title: String) {
        titleLabel.text = title
    }

    /**
     Set subtitle

     - parameter subtitle: Subtitle string
     */
    public func set(subtitle: String) {
        subtitleLabel.text = subtitle
    }

}
