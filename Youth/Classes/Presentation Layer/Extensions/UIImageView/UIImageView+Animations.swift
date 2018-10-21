//
//  UIImageView+Animations.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

// swiftlint:disable all

import UIKit

extension UIImageView {
    func animateFadeInappearance() {
        let finalAlpha = alpha
        alpha = 0
        UIView.animate(withDuration: 0.35,
                       delay: 0.0,
                       options: [.allowUserInteraction, .curveEaseInOut, .allowAnimatedContent],
                       animations: { [weak self] in
                        self?.alpha = finalAlpha
        })
    }
}
