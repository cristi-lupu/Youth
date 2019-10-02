//
//  YouthNavigationBar.swift
//  Youth
//
//  Created by Cristian Lupu on 5/20/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import UIKit

/// Main navigation bar of app
final class YouthNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        topItem?.title = ""
    }

    private func commonInit() {
        let backImage = UIImage(named: "Actions/navigation-arrow")
        backIndicatorImage = backImage
        backIndicatorTransitionMaskImage = backImage
    }

}
