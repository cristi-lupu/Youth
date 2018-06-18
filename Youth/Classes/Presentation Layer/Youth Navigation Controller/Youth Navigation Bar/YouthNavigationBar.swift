//
//  YouthNavigationBar.swift
//  Youth
//
//  Created by Lupu Cristian on 5/20/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Main navigation bar of app
public final class YouthNavigationBar: UINavigationBar {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        let backImage = R.image.actions.navigationArrow()
        backIndicatorImage = backImage
        backIndicatorTransitionMaskImage = backImage
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        topItem?.title = ""
    }

}
